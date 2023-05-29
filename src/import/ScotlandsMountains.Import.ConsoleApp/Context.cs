namespace ScotlandsMountains.Import.ConsoleApp;

internal class Context
{
    public Context(
        FileInfo hillCsv,
        FileInfo outputJson,
        IdGenerator idGenerator,
        StatusReporter statusReporter,
        ClassificationData classificationData)
    {
        HillCsv = hillCsv;
        OutputJson = outputJson;
        IdGenerator = idGenerator;
        StatusReporter = statusReporter;
        ClassificationData = classificationData;
    }

    public virtual FileInfo HillCsv { get; }
    public FileInfo OutputJson { get; }
    public virtual IdGenerator IdGenerator { get; }
    public virtual StatusReporter StatusReporter { get; }
    public virtual ClassificationData ClassificationData { get; }
    
    public virtual IReadOnlyList<DobihRecord> DobihRecords { get; set; } = null!;
    
    public virtual IDictionary<int, MountainRecordWrapper> MountainsByDobihId { get; set; } = null!;
    public virtual IList<ClassificationWrapper> WrappedClassifications { get; set; } = null!;
    public virtual IDictionary<char, Entity> CountriesByInitial { get; set; } = null!;

    public Data DataForUpload { get; set; } = null!;
}