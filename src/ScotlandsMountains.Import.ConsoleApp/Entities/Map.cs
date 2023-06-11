namespace ScotlandsMountains.Import.ConsoleApp.Entities;

public class Map : Entity
{
    public string Code { get; set; } = null!;

    public decimal Scale { get; set; }
    
    public List<Mountain> Mountains { get; set; } = new();

    public override string ToString()
    {
        return $"1:{decimal.Divide(1, Scale):#,##0}: {Code} ({Id})";
    }
}