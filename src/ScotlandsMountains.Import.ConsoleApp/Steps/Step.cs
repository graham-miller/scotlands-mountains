namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal abstract class Step
{
    protected const bool LogTime = true;

    private readonly bool _logTime;

    protected Step(bool logTime = false)
    {
        _logTime = logTime;
    }

    public void Execute(Context context)
    {
        context.StatusReporter.SetStatus(GetStatusMessage(context));

        var stopwatch = new Stopwatch();
        stopwatch.Start();
        Implementation(context);
        stopwatch.Stop();

        context.StatusReporter.LogSuccess(GetSuccessMessage(context) + (_logTime ? $" [{stopwatch.Elapsed.Humanize()}]" : ""));
    }

    protected abstract string GetStatusMessage(Context context);

    protected abstract void Implementation(Context context);

    protected abstract string GetSuccessMessage(Context context);
}