namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal class AssignMapsStep : Step
{
    protected override string GetStatusMessage(Context context) => "Assign maps...";

    protected override void Implementation(Context context)
    {
        var landrangerLookup = context.MapPublisher.Series
            .Single(x => x.Name == MapSeries.Names.Landranger)
            .Maps
            .ToDictionary(k => k.Code);
        var explorerLookup = context.MapPublisher.Series
            .Single(x => x.Name == MapSeries.Names.Explorer)
            .Maps
            .ToDictionary(k => k.Code);

        foreach (var item in context.MountainsByDobihId.Values)
        {
            var maps = new List<Map>();

            item.Dobih.Map1To50K?.Split(' ')
                .Where(s => !string.IsNullOrWhiteSpace(s))
                .ToList()
                .ForEach(c =>
                {
                    if (landrangerLookup.TryGetValue(RemoveMapSide(c), out var value))
                        maps.Add(value);
                });

            item.Dobih.Map1To25K?.Split(' ')
                .Where(s => !string.IsNullOrWhiteSpace(s))
                .ToList()
                .ForEach(c =>
                {
                    if (explorerLookup.TryGetValue(RemoveMapSide(c), out var value))
                        maps.Add(value);
                });

            item.Value.Maps = maps;

            foreach (var map in maps)
            {
                map.Mountains.Add(item.Value);
            }
        }
    }

    protected override string GetSuccessMessage(Context context) => "Assigned maps";

    private static readonly char[] MapSides = { 'N', 'E', 'S', 'W' };

    private static string RemoveMapSide(string s)
    {
        return MapSides.Contains(s.Last()) ? s[..^1] : s;
    }
}