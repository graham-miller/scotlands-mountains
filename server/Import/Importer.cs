using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.IO.Compression;
using System.Reflection;
using CsvHelper;

namespace ScotlandsMountains.Import
{
    public class Importer
    {
        private readonly List<Record> _records = new List<Record>();

        public void Import()
        {
            ReadCsv();
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
                //RecordPropertyNames.Generate(csv.Context.HeaderRecord);

                while (csv.Read())
                    _records.Add(csv.GetRecord<Record>());
            }
        }
    }
}
