namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal class AssignParentMountainStep : Step
{
    protected override void SetStatus(Context context)
    {
        context.StatusReporter.SetStatus("Assigning parent mountains...");
    }

    protected override void Implementation(Context context)
    {
        foreach (var item in context.MountainsByDobihId.Values)
        {
            var parentId = item.Record.ParentMa;

            if (parentId != 0 && parentId != item.Record.Number)
                item.Mountain.Parent = context.MountainsByDobihId[parentId].Summary;
        }

    }

    protected override void LogSuccess(Context context)
    {
        context.StatusReporter.LogSuccess("Parent mountains assigned");
    }
}