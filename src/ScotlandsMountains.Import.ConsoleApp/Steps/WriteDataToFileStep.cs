namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal class WriteDataToFileStep : Step
{
    protected override string GetStatusMessage(Context context) => "Writing data to file...";

    protected override void Implementation(Context context)
    {
        if (context.FileManager.OutputJson.Exists) context.FileManager.OutputJson.Delete();

        var options = new JsonSerializerOptions
        {
            PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
            WriteIndented = true
        };

        var contents = JsonSerializer.Serialize(context.Domain, options);
        File.AppendAllText(context.FileManager.OutputJson.FullName, contents);
    }

    protected override string GetSuccessMessage(Context context) => "Data written to file";
}