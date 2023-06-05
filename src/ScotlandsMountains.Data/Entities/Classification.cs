namespace ScotlandsMountains.Data.Entities;

public class Classification : Entity
{
    public string NameSingular { get; set; } = null!;
    
    public string Description { get; set; } = null!;

    [JsonIgnore]
    public List<Mountain> Mountains { get; set; } = new();
}