namespace ScotlandsMountains.Import.ConsoleApp.Models;

internal class MapSummary : Entity
{
    public string Code { get; set; } = null!;
    public decimal Scale { get; set; }
}