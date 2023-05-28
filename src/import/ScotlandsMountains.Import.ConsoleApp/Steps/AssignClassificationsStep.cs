namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal class AssignClassificationsStep : Step
{
    protected override void SetStatus(Context context)
    {
        context.StatusReporter.SetStatus("Assigning classifications...");
    }

    protected override void Implementation(Context context)
    {
        foreach (var classification in context.Classifications)
        {
            foreach (var mountain in context.MountainsByDobihId.Values.Where(mountain => classification.Info.IsMember(mountain.Record)))
            {
                mountain.Mountain.Classifications.Add(classification.Summary);
                classification.Classification.Mountains.Add(mountain.Summary);
            }
        }
    }

    protected override void LogSuccess(Context context)
    {
        context.StatusReporter.LogSuccess("Classifications assigned");
    }
}