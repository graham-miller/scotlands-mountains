namespace ScotlandsMountains.Import.ConsoleApp;

internal class Context
{
    public Context(
        FileInfo hillCsv,
        IdGenerator idGenerator,
        StatusReporter statusReporter)
    {
        HillCsv = hillCsv;
        IdGenerator = idGenerator;
        StatusReporter = statusReporter;
    }

    public virtual FileInfo HillCsv { get; }

    public virtual IdGenerator IdGenerator { get; }

    public virtual StatusReporter StatusReporter { get; }

    public virtual IReadOnlyList<DobihRecord> DobihRecords { get; set; } = null!;

    public Dictionary<int, Mountain> Mountains { get; set; } = null!;
}