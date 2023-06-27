namespace ScotlandsMountains.Import.ConsoleApp.Entities;

public class Country : Entity
{
    public bool IsEnabled { get; set; }

    public List<Mountain> Mountains { get; set; } = new();
}