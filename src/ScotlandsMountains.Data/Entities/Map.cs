namespace ScotlandsMountains.Data.Entities;

public class Map : Entity
{
    public string Code { get; set; } = null!;

    public decimal Scale { get; set; }
    
    [JsonIgnore]
    public List<Mountain> Mountains { get; set; } = new();
}