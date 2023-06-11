namespace ScotlandsMountains.Import.ConsoleApp.Entities;

public class Entity
{
    public string Id { get; set; } = null!;
    public string Name { get; set; } = null!;

    public override string ToString()
    {
        return $"{Name} ({Id})";
    }
}