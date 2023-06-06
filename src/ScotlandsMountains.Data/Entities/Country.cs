namespace ScotlandsMountains.Data.Entities;

public class Country : Entity
{
    public List<Mountain> Mountains { get; set; } = new();
}