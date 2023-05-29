namespace ScotlandsMountains.Import.ConsoleApp.Models;

internal class Data
{
    public IList<Mountain> Mountains { get; set; } = null!;
    public IList<Classification> Classifications { get; set; } = null!;
    public IList<Entity> Countries { get; set; } = null!;
    public IList<Region> Regions { get; set; } = null!;
    public IList<Entity> Maps { get; set; } = null!;
}