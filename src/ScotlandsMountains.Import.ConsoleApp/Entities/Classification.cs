namespace ScotlandsMountains.Import.ConsoleApp.Entities;

public class Classification : Entity
{
    public int? DisplayOrder { get; set; }

    public bool IsActive { get; set; }
    
    public string NameSingular { get; set; } = null!;
    
    public string Description { get; set; } = null!;

    public List<MountainClassification> Mountains { get; set; } = new();
}