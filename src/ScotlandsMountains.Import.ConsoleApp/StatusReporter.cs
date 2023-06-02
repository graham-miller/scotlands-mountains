namespace ScotlandsMountains.Import.ConsoleApp;

internal class StatusReporter
{
    public const string GreenCheck = "[lime]✓[/]";

    private readonly StatusContext _statusContext;
    private readonly IAnsiConsole _ansiConsole;

    public StatusReporter(StatusContext statusContext, IAnsiConsole ansiConsole)
    {
        _statusContext = statusContext;
        _ansiConsole = ansiConsole;
    }

    public virtual void SetStatus(string status)
    {
        _statusContext.Status(status);
    }

    public virtual void LogSuccess(string message)
    {
        _ansiConsole.MarkupLine(GreenCheck + " " + Markup.Escape(message));
    }
}