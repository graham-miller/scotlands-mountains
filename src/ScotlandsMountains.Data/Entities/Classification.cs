namespace ScotlandsMountains.Data.Entities;

public class Classification : Entity
{
    public string NameSingular { get; set; } = null!;
    
    public string Description { get; set; } = null!;

    [JsonIgnore]
    public IList<Mountain> Mountains { get; set; } = new List<Mountain>();
}