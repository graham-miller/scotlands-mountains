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

    public static MapSummary ToSummary(this Map map)
    {
        return new MapSummary()
        {
            Id = map.Id,
            Name = map.Name,
            Code = map.Code,
            Scale = map.Scale
        };
    }

    private static readonly Regex RawGridRefRegex = new("^[A-Z]{1,2}[0-9 ]{6,12}$");

    public static string FormatAsGridRef(this string s)
    {

        if (string.IsNullOrEmpty(s) || !RawGridRefRegex.IsMatch(s)) return s;

        var withoutSpaces = string.Concat(s.Where(x => x != ' '));
        var letters = string.Concat(withoutSpaces.Where(char.IsLetter));
        var numbers = string.Concat(withoutSpaces.Where(char.IsNumber));

        if (numbers.Length % 2 != 0) return s;

        var easting = numbers.Substring(0, numbers.Length / 2);
        var northing = numbers.Substring(numbers.Length / 2, numbers.Length / 2);

        easting = easting.PadRight(5, '0');
        northing = northing.PadRight(5, '0');

        return $"{letters} {easting} {northing}";
    }
}