namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal class WritingDataToFileStep : Step
{
    protected override void SetStatus(Context context)
    {
        context.StatusReporter.SetStatus("Writing data to file...");
    }

    protected override void Implementation(Context context)
    {
        if (context.OutputJson.Exists) context.OutputJson.Delete();

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
        context.StatusReporter.LogSuccess("Data written to file");
    }
}