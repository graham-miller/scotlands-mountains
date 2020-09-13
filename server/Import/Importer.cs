using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Globalization;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Reflection;
using CsvHelper;
using ScotlandsMountains.Domain;

namespace ScotlandsMountains.Import
{
    public class Importer
    {
        private readonly List<Record> _records = new List<Record>();

        public IList<Classification> Classifications { get; } = new List<Classification>();

        public IList<Section> Sections { get; } = new List<Section>();
        
        public IList<County> Counties { get; } = new List<County>();
        
        public IList<Map> Maps { get; } = new List<Map>();

        public IList<Mountain> Mountains { get; } = new List<Mountain>();

        public void Import()
        {
            ReadCsv();
            ParseClassifications();
            ParseSections();
            ParseCounties();
            ParseMaps();
            ParseMountains();
            AssignIds();
        }

        private void AssignIds()
        {
            IdGenerator.ApplyIdsTo(Classifications);
            IdGenerator.ApplyIdsTo(Sections);
            IdGenerator.ApplyIdsTo(Counties);
            IdGenerator.ApplyIdsTo(Maps);
            IdGenerator.ApplyIdsTo(Mountains);
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
            var classificationLookup = new ClassificationLookup();

            _records
                .SelectMany(record => record.Classification.Split(','))
                .Select(key => key.Trim())
                .Distinct()
                .Select(key => new Classification
                {
                    DobihId = key,
                    Name = classificationLookup[key]
                })
                .ToList()
                .ForEach(classification => Classifications.Add(classification));
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
                .ForEach(section => Sections.Add(section));
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
                .ForEach(county => Counties.Add(county));
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
                .ForEach(map => Maps.Add(map));
        }

        private void ParseMountains()
        {
            _records
                .Select(record =>
                {
                    var classifications = record.Classification.Split(',')
                        .Select(key => key.Trim())
                        .Select(key => Classifications.Single(classification => classification.DobihId == key))
                        .ToList();

                    var maps1To25k = record.Map1To25k.Split(' ')
                        .Select(code => code.Trim())
                        .Select(code => Maps.Single(map => map.Scale == Map.Scale1To25000 && map.Code == code));
                    var maps1To50k = record.Map1To50k.Split(' ')
                        .Select(code => code.Trim())
                        .Select(code => Maps.Single(map => map.Scale == Map.Scale1To50000 && map.Code == code));

                    return new Mountain
                    {
                        DobihId = record.Number,
                        Name = record.Name,
                        Section = Sections.Single(section => section.DobihId == record.Region),
                        Classifications = classifications,
                        Height = record.Metres,
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
                        County = Counties.Single(county => county.Name == record.County),
                        Maps = maps1To50k.Concat(maps1To25k).ToList()
                    };
                })
                .OrderByDescending(mountain => mountain.Height)
                .ToList()
                .ForEach(mountain => Mountains.Add(mountain));
        }
    }
}
