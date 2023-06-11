namespace ScotlandsMountains.Import.ConsoleApp.Entities;

public class Country : Entity
{
    public List<Mountain> Mountains { get; set; } = new();
}