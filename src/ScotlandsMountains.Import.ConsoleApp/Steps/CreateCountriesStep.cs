namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal class CreateCountriesStep : Step
{
    protected override string GetStatusMessage(Context context) => "Creating countries...";

    protected override void Implementation(Context context)
    {
        context.CountriesByInitial = new Dictionary<char, Country>
        {
            { 'S', new() { Name = "Scotland" } },
            { 'E', new() { Name = "England" } },
            { 'W', new() { Name = "Wales" } },
            { 'I', new() { Name = "Ireland" } },
            { 'C', new() { Name = "Channel Islands" } },
            { 'M', new() { Name = "Isle of Man" } }
        };
    }

    protected override string GetSuccessMessage(Context context) => $"Created {context.CountriesByInitial.Count:#,##0} countries";
}