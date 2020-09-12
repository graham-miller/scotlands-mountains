using System.Collections.Generic;
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

        public void Import()
        {
            ReadCsv();
            ParseClassifications();
            ParseSections();
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
                .SelectMany(x => x.Classification.Split(','))
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
                .Select(x => x.Region)
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
    }
}
