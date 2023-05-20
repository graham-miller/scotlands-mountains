namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal class ReadHillCsvZipStep : Step
{
    public override void Execute(Context context)
    {
        var fileInfo = new FileInfo(context.HillCsvPath);

        context.StatusReporter.SetStatus($"Loading {fileInfo.Name}...");

        using var file = new FileStream(fileInfo.FullName, FileMode.Open);
        using var zip = new ZipArchive(file);
        using var entry = zip.Entries.Single().Open();
        using var reader = new StreamReader(entry);
        using var csv = new CsvReader(reader, CultureInfo.InvariantCulture);

        context.DobihRecords = csv.GetRecords<Record>().ToList();
        context.StatusReporter.LogSuccess($"Loaded {context.DobihRecords.Count:#,##0} records from {fileInfo.Name}");
    }
}