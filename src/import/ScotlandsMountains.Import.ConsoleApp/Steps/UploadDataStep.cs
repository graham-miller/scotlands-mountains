namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal class UploadDataStep : Step
{
    protected override void SetStatus(Context context)
    {
        context.StatusReporter.SetStatus("Uploading data...");
    }

    protected override void Implementation(Context context)
    {
        var options = new JsonSerializerOptions
        {
            PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
            WriteIndented = true
        };

        var contents = JsonSerializer.Serialize(context.DataForUpload, options);
        File.AppendAllText(context.OutputJson.FullName, contents);
    }

    protected override void LogSuccess(Context context)
    {
        context.StatusReporter.LogSuccess("Data uploaded");
    }
}