namespace ScotlandsMountains.Import.ConsoleApp.Entities;

public class MapPublisher : Entity
{
    public List<MapSeries> Series { get; set; } = new();
}