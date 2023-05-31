namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal abstract class Step
{
    public void Execute(Context context)
    {
        context.StatusReporter.SetStatus(GetStatusMessage(context));

        Implementation(context);

        context.StatusReporter.LogSuccess(GetSuccessMessage(context));
    }

    protected abstract string GetStatusMessage(Context context);

    protected abstract void Implementation(Context context);

    protected abstract string GetSuccessMessage(Context context);
}