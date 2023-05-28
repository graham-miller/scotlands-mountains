namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal class CreateMountainsStep : Step
{
    protected override void SetStatus(Context context)
    {
        context.StatusReporter.SetStatus("Creating mountains...");
    }

    protected override void Implementation(Context context)
    {
        context.MountainsByDobihId = context.DobihRecords
            .ToDictionary(
                x => x.Number,
                x => new MountainRecordWrapper(x, context.IdGenerator.Next));
    }

    protected override void LogSuccess(Context context)
    {
        context.StatusReporter.LogSuccess($"Created {context.MountainsByDobihId.Count:#,##0} mountains");
    }
}