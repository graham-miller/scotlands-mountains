namespace ScotlandsMountains.Import.ConsoleApp.Models;

internal class RegionSummary : Entity
{
    public string Code { get; set; } = null!;
}

internal class Region : RegionSummary
{
    public IList<MountainSummary> Mountains { get; set; } = new List<MountainSummary>();
}