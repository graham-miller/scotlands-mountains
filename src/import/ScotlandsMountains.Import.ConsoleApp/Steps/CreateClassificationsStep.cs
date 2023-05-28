namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal class CreateClassificationsStep : Step
{
    protected override void SetStatus(Context context)
    {
        context.StatusReporter.SetStatus("Creating classifications...");
    }

    protected override void Implementation(Context context)
    {
        context.Classifications = context.ClassificationData
            .Select(x => new ClassificationWrapper(x, context.IdGenerator.Next))
            .ToList();
    }

    protected override void LogSuccess(Context context)
    {
        context.StatusReporter.LogSuccess($"Created {context.Classifications.Count:#,##0} classifications");
    }
}