namespace ScotlandsMountains.Data.Entities;

public class Region : Entity
{
    public string Code { get; set; } = null!;

    [JsonIgnore]
    public List<Mountain> Mountains { get; set; } = new();
}