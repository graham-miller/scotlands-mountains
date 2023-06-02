namespace ScotlandsMountains.Import.ConsoleApp.Config;

public class ClassificationInfo
{
    public string Name { get; }
    public string NameSingular { get; }
    public string Description { get; }
    public Func<DobihRecord, bool> IsMember { get; }

    public ClassificationInfo(string name, string nameSingular, Func<DobihRecord, bool> isMember, string description)
    {
        Name = name;
        NameSingular = nameSingular;
        Description = description;
        IsMember = isMember;
    }
}