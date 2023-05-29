namespace ScotlandsMountains.Import.ConsoleApp.Models;

internal class Map : MapSummary
{
    public IList<MountainSummary> Mountains { get; set; } = new List<MountainSummary>();
}