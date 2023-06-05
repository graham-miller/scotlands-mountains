namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal class AssignParentMountainStep : Step
{
    protected override string GetStatusMessage(Context context) => "Assigning parent mountains...";

    protected override void Implementation(Context context)
    {
        foreach (var item in context.MountainsByDobihId.Values)
        {
            var parentId = item.Dobih.ParentMa;

            if (parentId != 0 && parentId != item.Dobih.Number)
                item.Value.Parent = context.MountainsByDobihId[parentId].Value;
        }

    }

    protected override string GetSuccessMessage(Context context) => "Parent mountains assigned";
}