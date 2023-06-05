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
    public IList<string> Aliases { get; set; } = null!;

    [JsonIgnore]
    public IList<Classification> Classifications { get; set; } = new List<Classification>();
    
    [JsonIgnore]
    public IList<Country> Countries { get; set; } = new List<Country>();
    
    [JsonIgnore]
    public Region Region { get; set; } = null!;
    
    [JsonIgnore]
    public IList<Map> Maps { get; set; } = new List<Map>();

    public int DobihId { get; set; }
}