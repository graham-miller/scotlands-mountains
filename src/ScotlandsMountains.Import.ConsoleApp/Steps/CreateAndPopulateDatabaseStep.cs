namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal class CreateAndPopulateDatabaseStep : Step
{
    protected override string GetStatusMessage(Context context) => "Creating and populating database...";

    protected override void Implementation(Context context)
    {
        if (context.FileManager.OutputDb.Exists) context.FileManager.OutputDb.Delete();

        using var dbContext = new ScotlandsMountainsDbContext(context.FileManager.OutputDb);

        var mountains = context.MountainsByDobihId.Values
            .OrderByDescending(x => x.Value.Height)
            .Select(x => x.Value)
            .ToList();

        dbContext.Database.EnsureCreated();
        dbContext.Mountains.AddRange(mountains);
        dbContext.SaveChanges();
    }

    protected override string GetSuccessMessage(Context context) => "Database created and populated";
}