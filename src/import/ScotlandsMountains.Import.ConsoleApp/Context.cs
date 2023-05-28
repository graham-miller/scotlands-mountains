namespace ScotlandsMountains.Import.ConsoleApp;

internal class Context
{
    public Context(
        FileInfo hillCsv,
        IdGenerator idGenerator,
        StatusReporter statusReporter,
        ClassificationData classificationData)
    {
        HillCsv = hillCsv;
        IdGenerator = idGenerator;
        StatusReporter = statusReporter;
        ClassificationData = classificationData;
    }

    public virtual FileInfo HillCsv { get; }
    public virtual IdGenerator IdGenerator { get; }
    public virtual StatusReporter StatusReporter { get; }
    public virtual ClassificationData ClassificationData { get; }
    
    public virtual IReadOnlyList<DobihRecord> DobihRecords { get; set; } = null!;
    
    public virtual Dictionary<int, MountainRecordWrapper> MountainsByDobihId { get; set; } = null!;
    public IList<ClassificationWrapper> Classifications { get; set; } = null!;
}