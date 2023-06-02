namespace ScotlandsMountains.Import.ConsoleApp.Extensions;

internal static class EntityExtensions
{
    public static MountainSummary ToSummary(this Mountain mountain)
    {
        return new MountainSummary
        {
            Id = mountain.Id,
            Name = mountain.Name,
            Latitude = mountain.Latitude,
            Longitude = mountain.Longitude,
            Height = mountain.Height,
        };
    }

    public static Entity ToSummary(this Entity entity)
    {
        return new Entity
        {
            Id = entity.Id,
            Name = entity.Name
        };
    }

    public static RegionSummary ToSummary(this Region region)
    {
        return new RegionSummary
        {
            Id = region.Id,
            Name = region.Name,
            Code = region.Code,
        };
    }

    public static MapSummary ToSummary(this Map map)
    {
        return new MapSummary
        {
            Id = map.Id,
            Name = map.Name,
            Code = map.Code,
            Scale = map.Scale
        };
    }
}