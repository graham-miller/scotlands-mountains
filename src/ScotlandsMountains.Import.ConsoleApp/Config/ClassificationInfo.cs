namespace ScotlandsMountains.Import.ConsoleApp.Config;

public class ClassificationInfo
{
    public string Name { get; }
    public int? DisplayOrder { get; }
    public bool IsActive { get; }
    public string NameSingular { get; }
    public string Description { get; }
    public Func<DobihRecord, bool> IsMember { get; }

    public ClassificationInfo(string name, int? displayOrder, bool isActive, string nameSingular, Func<DobihRecord, bool> isMember, string description)
    {
        Name = name;
        DisplayOrder = displayOrder;
        IsActive = isActive;
        NameSingular = nameSingular;
        Description = description;
        IsMember = isMember;
    }
}