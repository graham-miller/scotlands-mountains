namespace ScotlandsMountains.Import.ConsoleApp.Models;

internal class Domain
{
    public IList<Mountain> Mountains { get; set; } = null!;
    
    public IList<Classification> Classifications { get; set; } = null!;
    
    public IList<Country> Countries { get; set; } = null!;
    
    public IList<Region> Regions { get; set; } = null!;

    public IList<Map> Maps { get; set; } = null!;
}