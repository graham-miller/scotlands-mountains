namespace ScotlandsMountains.Import.ConsoleApp.Models;

public class ClassificationLite
{
    public ClassificationLite(Classification classification)
    {
        Id = classification.Id;
        Name = classification.Name;
        DisplayOrder = classification.DisplayOrder;
        IsActive = classification.IsActive;
        NameSingular = classification.NameSingular;
        Description = classification.Description;
        Mountains = classification.Mountains.Select(x => x.ToString()).ToList();
    }

    public string Id { get; }

    public string Name { get; }

    public int? DisplayOrder { get; set; }

    public bool IsActive { get; set; }

    public string NameSingular { get; }

    public string Description { get; }

    public List<string> Mountains { get; }
}