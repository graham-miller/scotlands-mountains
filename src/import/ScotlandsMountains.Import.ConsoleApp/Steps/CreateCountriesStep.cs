namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal class CreateCountriesStep : Step
{
    protected override void SetStatus(Context context)
    {
        context.StatusReporter.SetStatus("Creating countries...");
    }

    protected override void Implementation(Context context)
    {
        context.CountriesByInitial = new Dictionary<char, Entity>
        {
            { 'S', new() { Id = context.IdGenerator.Next, Name = "Scotland" } },
            { 'E', new() { Id = context.IdGenerator.Next, Name = "England" } },
            { 'W', new() { Id = context.IdGenerator.Next, Name = "Wales" } },
            { 'I', new() { Id = context.IdGenerator.Next, Name = "Ireland" } },
            { 'C', new() { Id = context.IdGenerator.Next, Name = "Channel Islands" } },
            { 'M', new() { Id = context.IdGenerator.Next, Name = "Isle of Man" } }
        };
    }

    protected override void LogSuccess(Context context)
    {
        context.StatusReporter.LogSuccess($"Created {context.CountriesByInitial.Count:#,##0} countries");
    }
}