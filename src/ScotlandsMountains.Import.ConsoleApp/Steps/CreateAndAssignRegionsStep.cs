namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal class CreateAndAssignRegionsStep : Step
{
    protected override string GetStatusMessage(Context context) => "Create and assign regions...";

    protected override void Implementation(Context context)
    {
        var lookup = context.DobihRecords
            .Select(x => x.Region)
            .Distinct()
            .Select(raw => new RegionWrapper(raw, context.IdGenerator.Next()))
            .ToDictionary(k => k.Code);

        context.Regions = lookup.Values.Select(x => x.Region).ToList();

        foreach (var item in context.MountainsByDobihId.Values)
        {
            var code = item.Record.Region.Split(':')[0].Trim();
            item.Mountain.Region = lookup[code].Summary;
            lookup[code].Region.Mountains.Add(item.Summary);
        }
    }

    protected override string GetSuccessMessage(Context context) => $"Created and assigned {context.Regions.Count:#,##0} regions";
}