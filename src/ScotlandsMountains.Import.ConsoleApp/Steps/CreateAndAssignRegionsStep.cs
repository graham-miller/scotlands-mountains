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

        context.Regions = lookup.Values.Select(x => x.Value).ToList();

        foreach (var item in context.MountainsByDobihId.Values)
        {
            var code = item.Dobih.Region.Split(':')[0].Trim();
            item.Value.Region = lookup[code].Value;
            lookup[code].Value.Mountains.Add(item.Value);
        }
    }

    protected override string GetSuccessMessage(Context context) => $"Created and assigned {context.Regions.Count:#,##0} regions";
}