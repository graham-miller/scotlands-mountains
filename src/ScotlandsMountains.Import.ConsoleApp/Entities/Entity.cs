namespace ScotlandsMountains.Import.ConsoleApp.Entities;

public abstract class Entity
{
    public int Id { get; set; }
    public string Name { get; set; } = null!;

    public override string ToString()
    {
        return $"{Name} ({Id})";
    }
}