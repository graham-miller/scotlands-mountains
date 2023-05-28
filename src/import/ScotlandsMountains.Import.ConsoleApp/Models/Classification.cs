namespace ScotlandsMountains.Import.ConsoleApp.Models;

internal class Classification : Entity
{
    public string NameSingular { get; set; } = null!;
    public string Description { get; set; } = null!;
    public IList<MountainSummary> Mountains { get; set; } = new List<MountainSummary>();
}