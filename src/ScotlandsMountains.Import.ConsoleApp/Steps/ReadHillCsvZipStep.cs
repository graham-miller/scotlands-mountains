namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal class ReadHillCsvZipStep : Step
{
    protected override string GetStatusMessage(Context context) =>
        $"Loading {context.FileManager.HillCsv.Name}...";

    protected override void Implementation(Context context)
    {
        using var file = new FileStream(context.FileManager.HillCsv.FullName, FileMode.Open);
        using var zip = new ZipArchive(file);
        using var entry = zip.Entries.Single().Open();
        using var reader = new StreamReader(entry);
        using var csv = new CsvReader(reader, CultureInfo.InvariantCulture);

        context.DobihRecords = csv.GetRecords<DobihRecord>().ToList();
    }

    protected override string GetSuccessMessage(Context context) =>
        $"Loaded {context.DobihRecords.Count:#,##0} records from {context.FileManager.HillCsv.Name}";
}