namespace ScotlandsMountains.Import.ConsoleApp.Models;

public class MountainLite
{
    public MountainLite(Mountain mountain)
    {
        Id = mountain.Id;
        Name = mountain.Name;
        Latitude = mountain.Latitude;
        Longitude = mountain.Longitude;
        GridRef = mountain.GridRef;
        Height = mountain.Height;
        Feature = mountain.Feature;
        Observations = mountain.Observations;
        Drop = mountain.Drop;
        Col = mountain.Col;
        ColHeight = mountain.ColHeight;
        Parent = mountain.Parent?.ToString();
        Aliases = mountain.Aliases;
        Classifications = mountain.Classifications.Select(x => x.ToString()).ToList();
        Countries = mountain.Countries.Select(x => x.ToString()).ToList();
        Region = mountain.Region.ToString();
        Maps = mountain.Maps.Select(x => x.ToString()).ToList();
        DobihId = mountain.DobihId;
    }

    public string Id { get; }

    public string Name { get; }

    public decimal Latitude { get; set; }

    public decimal Longitude { get; set; }

    public string GridRef { get; }

    public decimal Height { get; set; }

    public string? Feature { get; set; }

    public string? Observations { get; set; }

    public decimal Drop { get; set; }

    public string Col { get; }

    public decimal ColHeight { get; set; }

    public string? Parent { get; }

    public List<string> Aliases { get; }

    public List<string> Classifications { get; }

    public List<string> Countries { get; }

    public string Region { get; }

    public List<string> Maps { get; }

    public int DobihId { get; set; }
}