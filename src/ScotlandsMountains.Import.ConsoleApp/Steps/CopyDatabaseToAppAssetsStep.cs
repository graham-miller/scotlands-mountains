namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal class CopyDatabaseToAppAssetsStep : Step
{
    protected override string GetStatusMessage(Context context) => "Copying database to assets...";

    protected override void Implementation(Context context)
    {
        context.FileManager.OutputDb.CopyTo(context.FileManager.AppAssetsDb.FullName, true);
    }

    protected override string GetSuccessMessage(Context context) => "Database copied to assets";
}