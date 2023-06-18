namespace ScotlandsMountains.Import.ConsoleApp;

internal class Context
{
    public Context(
        FileManager fileManager,
        StatusReporter statusReporter,
        ClassificationData classificationData)
    {
        FileManager = fileManager;
        StatusReporter = statusReporter;
        ClassificationData = classificationData;
    }

    public virtual FileManager FileManager { get; }
    
    public virtual StatusReporter StatusReporter { get; }
    
    public virtual ClassificationData ClassificationData { get; }
    
    public virtual IReadOnlyList<DobihRecord> DobihRecords { get; set; } = null!;
    
    public virtual IDictionary<int, MountainWrapper> MountainsByDobihId { get; set; } = null!;
    
    public virtual IList<ClassificationWrapper> WrappedClassifications { get; set; } = null!;
    
    public virtual IDictionary<char, Country> CountriesByInitial { get; set; } = null!;
    
    public virtual IList<Region> Regions { get; set; } = null!;
    
    public virtual IList<Map> Maps { get; set; } = null!;

    public virtual Domain Domain { get; set; } = null!;
}