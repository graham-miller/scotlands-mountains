using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Reflection;
using CsvHelper;
using Humanizer;

namespace ScotlandsMountains.Import
{
    public class Importer
    {
        public void Import()
        {
            var records = new List<Record>();

            var resourceStream = Assembly.GetAssembly(GetType()).GetManifestResourceStream($"{GetType().Namespace}.Resources.hillcsv.zip");
            using (var zipArchive = new ZipArchive(resourceStream))
            using (var fileStream = zipArchive.Entries[0].Open())
            using (var textReader = new StreamReader(fileStream))
            using (var csv = new CsvReader(textReader, CultureInfo.InvariantCulture))
            {
                csv.Read();
                csv.ReadHeader();

                var headerRecord = csv.Context.HeaderRecord;
                
                RecordPropertyNames.Generate(headerRecord);

                while (csv.Read())
                {
                    records.Add(csv.GetRecord<Record>());
                }
            }
        }

    }
}
