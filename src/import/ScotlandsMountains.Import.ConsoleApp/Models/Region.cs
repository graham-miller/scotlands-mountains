namespace ScotlandsMountains.Import.ConsoleApp.Models;

internal class Region : RegionSummary
{
    public IList<MountainSummary> Mountains { get; set; } = new List<MountainSummary>();
}