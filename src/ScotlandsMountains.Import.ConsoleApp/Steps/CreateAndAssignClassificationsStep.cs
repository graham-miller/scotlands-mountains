namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal class CreateAndAssignClassificationsStep : Step
{
    protected override string GetStatusMessage(Context context) => "Creating classifications...";

    protected override void Implementation(Context context)
    {
        context.WrappedClassifications = context.ClassificationData
            .Select(x => new ClassificationWrapper(x))
            .ToList();

        foreach (var classification in context.WrappedClassifications)
        {
            var mountains = context.MountainsByDobihId.Values
                .Where(m => classification.Info.IsMember(m.Dobih))
                .OrderByDescending(m => m.Value.Height);

            var rank = 0;

            foreach (var mountain in mountains)
            {
                rank++;

                var mountainClassification = new MountainClassification
                {
                    Mountain = mountain.Value,
                    Classification = classification.Value,
                    Rank = rank
                };

                mountain.Value.Classifications.Add(mountainClassification);
                classification.Value.Mountains.Add(mountainClassification);
            }
        }
    }

    protected override string GetSuccessMessage(Context context) => $"Created {context.WrappedClassifications.Count:#,##0} classifications";
}