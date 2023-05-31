namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal class CreateAndAssignMapsStep : Step
{
    protected override string GetStatusMessage(Context context) => "Create and assign maps...";

    protected override void Implementation(Context context)
    {
        var lookup1To50K = GetMaps(x => x.Map1To50K, decimal.Divide(1, 50_000), context);
        var lookup1To25K = GetMaps(x => x.Map1To25K, decimal.Divide(1, 25_000), context);

        context.Maps = lookup1To50K.Values.Select(x => x.Map).Concat(lookup1To25K.Values.Select(x => x.Map)).ToList();

        foreach (var item in context.MountainsByDobihId.Values)
        {
            var maps1To50K = item.Record.Map1To50K?.Split(' ').Select(x => lookup1To50K[x.Trim()]) ?? Enumerable.Empty<MapWrapper>();
            var maps1To25K = item.Record.Map1To25K?.Split(' ').Select(x => lookup1To25K[x.Trim()]) ?? Enumerable.Empty<MapWrapper>();
            var maps = maps1To50K.Concat(maps1To25K).ToList();

            item.Mountain.Maps = maps.Select(x => x.Summary).ToList();

            foreach (var map in maps)
            {
                map.Map.Mountains.Add(item.Summary);
            }
        }
    }

    protected override string GetSuccessMessage(Context context) => $"Created and assigned {context.Maps.Count:#,##0} maps";

    private static IDictionary<string, MapWrapper> GetMaps(Func<DobihRecord, string?> mapsFunc, decimal scale, Context context)
    {
        return context.DobihRecords
            .Select(mapsFunc)
            .SelectMany(x => x?.Split(' ') ?? Enumerable.Empty<string>())
            .Distinct()
            .Select(code => new Map
            {
                Id = context.IdGenerator.Next,
                Name = string.Empty,
                Code = code,
                Scale = scale
            })
            .Select(map => new MapWrapper(map))
            .ToDictionary(k => k.Map.Code, v => v);
    }

    private class MapWrapper
    {
        public MapWrapper(Map map)
        {
            Map = map;
            Summary = map.ToSummary();
        }

        public Map Map { get; }
        public MapSummary Summary { get; }
    }
}