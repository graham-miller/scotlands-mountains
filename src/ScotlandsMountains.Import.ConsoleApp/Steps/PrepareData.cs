namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal class PrepareData : Step
{
    protected override string GetStatusMessage(Context context) => "Preparing data...";

    protected override void Implementation(Context context)
    {
        context.Data = new Data
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
            Regions = context.Regions,
            Maps = context.Maps
        };
    }

    protected override string GetSuccessMessage(Context context) => "Data ready";
}