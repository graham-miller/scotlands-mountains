namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal class CreateCountriesStep : Step
{
    protected override string GetStatusMessage(Context context) => "Creating countries...";

    protected override void Implementation(Context context)
    {
        context.CountriesByInitial = new Dictionary<char, Country>
        {
            { 'S', new() { Name = "Scotland", IsEnabled = true } },
            { 'E', new() { Name = "England", IsEnabled = false } },
            { 'W', new() { Name = "Wales", IsEnabled = false } },
            { 'I', new() { Name = "Ireland", IsEnabled = false } },
            { 'C', new() { Name = "Channel Islands", IsEnabled = false } },
            { 'M', new() { Name = "Isle of Man", IsEnabled = false } }
        };
    }

    protected override string GetSuccessMessage(Context context) => $"Created {context.CountriesByInitial.Count:#,##0} countries";
}