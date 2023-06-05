namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal class PrepareData : Step
{
    protected override string GetStatusMessage(Context context) => "Preparing data...";

    protected override void Implementation(Context context)
    {
        context.Domain = new Domain
        {
            Mountains = context.MountainsByDobihId.Values
                .OrderByDescending(x => x.Value.Height)
                .Select(x => x.Value)
                .ToList(),
            Classifications = context.WrappedClassifications
                .Select(x => x.Value)
                .ToList(),
            Countries = context.CountriesByInitial.Values
                .ToList(),
            Regions = context.Regions,
            Maps = context.Maps
        };
    }

    protected override string GetSuccessMessage(Context context) => "Data ready";
}