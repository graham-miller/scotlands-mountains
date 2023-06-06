namespace ScotlandsMountains.Data.Entities;

public class Region : Entity
{
    public string Code { get; set; } = null!;

    public List<Mountain> Mountains { get; set; } = new();

    public override string ToString()
    {
        return $"{Code}:{Name} ({Id})";
    }
}