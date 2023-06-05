namespace ScotlandsMountains.Data.Entities;

public class Mountain : Entity
{
    public decimal Latitude { get; set; }

    public decimal Longitude { get; set; }
    
    public string GridRef { get; set; } = null!;
    
    public decimal Height { get; set; }
        
    public string? Feature { get; set; }
    
    public string? Observations { get; set; }

    public decimal Drop { get; set; }
    
    public string Col { get; set; } = null!;
    
    public decimal ColHeight { get; set; }

    [JsonIgnore]
    public Mountain Parent { get; set; } = null!;
    
    [JsonIgnore]
    public List<string> Aliases { get; set; } = null!;

    [JsonIgnore]
    public List<Classification> Classifications { get; set; } = new();
    
    [JsonIgnore]
    public List<Country> Countries { get; set; } = new();
    
    [JsonIgnore]
    public Region Region { get; set; } = null!;
    
    [JsonIgnore]
    public List<Map> Maps { get; set; } = new();

    public int DobihId { get; set; }
}