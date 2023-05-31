namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal class CreateAndAssignClassificationsStep : Step
{
    protected override string GetStatusMessage(Context context) => "Creating classifications...";

    protected override void Implementation(Context context)
    {
        context.WrappedClassifications = context.ClassificationData
            .Select(x => new ClassificationWrapper(x, context.IdGenerator.Next))
            .ToList();

        foreach (var classification in context.WrappedClassifications)
        {
            foreach (var mountain in context.MountainsByDobihId.Values.Where(mountain => classification.Info.IsMember(mountain.Record)))
            {
                mountain.Mountain.Classifications.Add(classification.Summary);
                classification.Classification.Mountains.Add(mountain.Summary);
            }
        }
    }

    protected override string GetSuccessMessage(Context context) => $"Created {context.WrappedClassifications.Count:#,##0} classifications";
}