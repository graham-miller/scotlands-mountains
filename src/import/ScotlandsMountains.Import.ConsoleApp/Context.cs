namespace ScotlandsMountains.Import.ConsoleApp;

internal class Context
{
    public Context(
        string hillCsvPath,
        IdGenerator idGenerator,
        StatusReporter statusReporter)
    {
        HillCsvPath = hillCsvPath;
        IdGenerator = idGenerator;
        StatusReporter = statusReporter;
    }

    public virtual string HillCsvPath { get; }

    public virtual IdGenerator IdGenerator { get; }

    public virtual StatusReporter StatusReporter { get; }

    public virtual IReadOnlyList<Record> DobihRecords { get; set; } = null!;

    public Dictionary<int, Mountain> Mountains { get; set; } = null!;
}