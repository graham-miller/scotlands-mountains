namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal class CopyDatabaseToAppResourcesStep : Step
{
    protected override string GetStatusMessage(Context context) => "Copying database to app resources...";

    protected override void Implementation(Context context)
    {
        context.FileManager.OutputDb.CopyTo(context.FileManager.AppResourcesRawDb.FullName, true);
    }

    protected override string GetSuccessMessage(Context context) => "Database copied to app resources";
}