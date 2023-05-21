namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal abstract class Step
{
    public void Execute(Context context)
    {
        SetStatus(context);
        Implementation(context);
        LogSuccess(context);
    }

    protected abstract void SetStatus(Context context);

    protected abstract void Implementation(Context context);

    protected abstract void LogSuccess(Context context);
}