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
}