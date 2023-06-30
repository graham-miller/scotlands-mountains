namespace ScotlandsMountains.Import.ConsoleApp.Entities;

public class MountainClassification
{
    public int Id { get; set; }

    public Classification Classification { get; set; } = null!;
        
    public Mountain Mountain { get; set; } = null!;

    public int Rank { get; set; }
}