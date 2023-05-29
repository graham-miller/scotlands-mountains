namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal class PrepareDataForUploadStep : Step
{
    protected override void SetStatus(Context context)
    {
        context.StatusReporter.SetStatus("Preparing data for upload...");
    }

    protected override void Implementation(Context context)
    {
        context.DataForUpload = new Data
        {
            Mountains = context.MountainsByDobihId.Values
                .OrderByDescending(x => x.Mountain.Height)
                .Select(x => x.Mountain)
                .ToList(),
            Classifications = context.WrappedClassifications
                .Select(x => x.Classification)
                .ToList(),
            Countries = context.CountriesByInitial.Values
                .ToList(),
            Regions = new List<Entity>(),
            Maps = new List<Entity>()
        };
    }

    protected override void LogSuccess(Context context)
    {
        context.StatusReporter.LogSuccess("Data ready for upload");
    }
}