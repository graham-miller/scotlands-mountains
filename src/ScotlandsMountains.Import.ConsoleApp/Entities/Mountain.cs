namespace ScotlandsMountains.Import.ConsoleApp.Entities;

public class Mountain : Entity
{
    public double Latitude { get; set; }

    public double Longitude { get; set; }
    
    public string GridRef { get; set; } = null!;
    
    public double Height { get; set; }
        
    public string? Feature { get; set; }
    
    public string? Observations { get; set; }

    public double Drop { get; set; }
    
    public string Col { get; set; } = null!;
    
    public double ColHeight { get; set; }

    public Mountain? Parent { get; set; } = null!;
    
    public List<Alias> Aliases { get; set; } = null!;

    public List<MountainClassification> Classifications { get; set; } = new();
    
    public List<Country> Countries { get; set; } = new();
    
    public Region Region { get; set; } = null!;
    
    public List<Map> Maps { get; set; } = new();

    public int DobihId { get; set; }
}
