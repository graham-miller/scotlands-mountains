using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Text.Json;
using CsvHelper;
using ScotlandsMountains.Domain;

namespace ScotlandsMountains.Import
{
    public class Importer
    {
        private readonly List<Record> _records = new List<Record>();

        private readonly IList<Classification> _classifications = new List<Classification>();

        private readonly IList<Section> _sections = new List<Section>();
        
        private readonly IList<County> _counties  = new List<County>();
        
        private readonly IList<Map> _maps = new List<Map>();

        private readonly IList<Mountain> _mountains = new List<Mountain>();

        public void Import()
        {
            ReadCsv();
            ParseClassifications();
            ParseSections();
            ParseCounties();
            ParseMaps();
            ParseMountains();
            ParseAliases();
            AssignIds();
            WriteToDataFile();
        }

        private void AssignIds()
        {
            IdGenerator.ApplyIdsTo(_classifications);
            IdGenerator.ApplyIdsTo(_sections);
            IdGenerator.ApplyIdsTo(_counties);
            IdGenerator.ApplyIdsTo(_maps);
            IdGenerator.ApplyIdsTo(_mountains);
        }

        private void ReadCsv()
        {
            using (var resourceStream = Assembly.GetAssembly(GetType()).GetManifestResourceStream($"{GetType().Namespace}.Resources.hillcsv.zip"))
            using (var zipArchive = new ZipArchive(resourceStream))
            using (var fileStream = zipArchive.Entries[0].Open())
            using (var textReader = new StreamReader(fileStream))
            using (var csv = new CsvReader(textReader, CultureInfo.InvariantCulture))
            {
                csv.Read();
                csv.ReadHeader();
                RecordPropertyNames.Generate(csv.Context.HeaderRecord);

                while (csv.Read())
                {
                    var record = csv.GetRecord<Record>();

                    if (record.Country == "S" || record.Country == "ES")
                        _records.Add(csv.GetRecord<Record>());
                }

            }
        }

        private void ParseClassifications()
        {
            var classificationFactory = new ClassificationFactory();

            _records
                .SelectMany(record => record.Classification.Split(','))
                .Select(key => key.Trim())
                .Distinct()
                .Select(key => classificationFactory.Build(key))
                .Where(classification => classification != null)
                .OrderBy(classification => classification.Order)
                .ToList()
                .ForEach(classification => _classifications.Add(classification));
        }

        private void ParseSections()
        {
            _records
                .Select(record => record.Region)
                .Distinct()
                .Select(region =>
                {
                    var parts = region.Split(':');
                    return new Section
                    {
                        DobihId = region,
                        Number = parts[0].Trim(),
                        Name = parts[1].Trim()
                    };
                })
                .OrderBy(section => section.Number)
                .ToList()
                .ForEach(section => _sections.Add(section));
        }

        private void ParseCounties()
        {
            _records
                .Select(record => record.County)
                .Distinct()
                .Select(county => new County
                {
                    DobihId = county,
                    Name = county
                })
                .OrderBy(county => county.Name)
                .ToList()
                .ForEach(county => _counties.Add(county));
        }

        private void ParseMaps()
        {
            var maps1To25k = _records
                .SelectMany(record => record.Map1To25k.Split(' '))
                .Select(code => code.Trim())
                .Distinct()
                .OrderBy(code => code)
                .Select(code => new Map
                {
                    DobihId = code,
                    Code = code,
                    Series = "Explorer",
                    Publisher = "Ordnance Survey",
                    Scale = Map.Scale1To25000
                });

            var maps1To50k = _records
                .SelectMany(record => record.Map1To50k.Split(' '))
                .Select(code => code.Trim())
                .Distinct()
                .OrderBy(code => code)
                .Select(code => new Map
                {
                    DobihId = code,
                    Code = code,
                    Series = "Landranger",
                    Publisher = "Ordnance Survey",
                    Scale = Map.Scale1To50000
                });

            maps1To50k
                .Concat(maps1To25k)
                .ToList()
                .ForEach(map => _maps.Add(map));
        }

        private void ParseMountains()
        {
            _records
                .Select(record =>
                {
                    var classifications = record.Classification.Split(',')
                        .Select(key => key.Trim())
                        .Select(key => _classifications.Single(classification => classification.DobihId == key))
                        .ToList();

                    var maps1To25k = record.Map1To25k.Split(' ')
                        .Select(code => code.Trim())
                        .Select(code => _maps.Single(map => map.Scale == Map.Scale1To25000 && map.Code == code));
                    var maps1To50k = record.Map1To50k.Split(' ')
                        .Select(code => code.Trim())
                        .Select(code => _maps.Single(map => map.Scale == Map.Scale1To50000 && map.Code == code));

                    return new Mountain
                    {
                        DobihId = record.Number,
                        Name = record.Name,
                        Section = _sections.Single(section => section.DobihId == record.Region),
                        Classifications = classifications,
                        Height = record.Metres,
                        Latitude = record.Latitude,
                        Longitude = record.Longitude,
                        GridRef = record.GridRef,
                        Prominence = new Prominence
                        {
                            Height = record.Drop,
                            From = record.ColGridRef,
                            FromHeight = record.ColHeight
                        },
                        Summit = new Summit
                        {
                            Description = record.Feature,
                            Notes = record.Observations
                        },
                        Island = string.IsNullOrEmpty(record.Island) ? null : record.Island,
                        County = _counties.Single(county => county.Name == record.County),
                        Maps = maps1To50k.Concat(maps1To25k).ToList()
                    };
                })
                .OrderByDescending(mountain => mountain.Height)
                .ToList()
                .ForEach(mountain => _mountains.Add(mountain));
        }

        private void ParseAliases()
        {
            foreach (var mountain in _mountains)
                MountainNameParser.Parse(mountain);
        }

        private void WriteToDataFile()
        {
            var root = new Root
            {
                Classifications = _classifications,
                Sections = _sections,
                Counties = _counties,
                Maps = _maps,
                Mountains = _mountains
            };

            var options = new JsonSerializerOptions {PropertyNamingPolicy = JsonNamingPolicy.CamelCase};
            var json = JsonSerializer.Serialize(root, options);
            var path = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.Desktop), "root.json.zip");

            using (var fileStream = File.Open(path, FileMode.Create))
            using (var zipArchive = new ZipArchive(fileStream, ZipArchiveMode.Create))
            {
                var entry = zipArchive.CreateEntry("root.json");

                using (var writer = new StreamWriter(entry.Open()))
                    writer.Write(json);
            }
        }
    }
}
