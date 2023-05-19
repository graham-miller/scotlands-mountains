using System.Globalization;
using System.IO.Compression;
using CsvHelper;

namespace ScotlandsMountains.Import.ConsoleApp.Dobih
{
    internal static class Parser
    {
        public static IReadOnlyList<Record> Parse(string path)
        {
            using var file = new FileStream(path, FileMode.Open);
            using var zip = new ZipArchive(file);
            using var entry = zip.Entries.Single().Open();
            using var reader = new StreamReader(entry);
            using var csv = new CsvReader(reader, CultureInfo.InvariantCulture);

            return csv.GetRecords<Record>().ToList();
        }
    }
}
