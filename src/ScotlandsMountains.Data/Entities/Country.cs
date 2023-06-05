namespace ScotlandsMountains.Data.Entities;

public class Country : Entity
{
    [JsonIgnore]
    public List<Mountain> Mountains { get; set; } = new();
}