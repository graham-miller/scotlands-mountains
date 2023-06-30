namespace ScotlandsMountains.Import.ConsoleApp.Entities;

public class Map : Entity
{
    public string Code { get; set; } = null!;

    public string Isbn { get; set; } = null!;

    public MapSeries Series { get; set; } = null!;

    public List<Mountain> Mountains { get; set; } = new();

    public override string ToString()
    {
        return $"1:{1/Series.Scale:#,##0}: {Code} {Name} ({Id})";
    }
}