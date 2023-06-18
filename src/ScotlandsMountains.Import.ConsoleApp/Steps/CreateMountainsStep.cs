namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal class CreateMountainsStep : Step
{
    protected override string GetStatusMessage(Context context) => "Creating mountains...";

    protected override void Implementation(Context context)
    {
        context.MountainsByDobihId = context.DobihRecords
            .ToDictionary(
                x => x.Number,
                x => new MountainWrapper(x, context));
    }

    protected override string GetSuccessMessage(Context context) => $"Created {context.MountainsByDobihId.Count:#,##0} mountains";
}