namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal class WriteDataToFileStep : Step
{
    protected override string GetStatusMessage(Context context) => "Writing data to file...";

    protected override void Implementation(Context context)
    {
        if (context.FileManager.OutputJson.Exists) context.FileManager.OutputJson.Delete();

        var options = new JsonSerializerOptions
        {
            PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
            WriteIndented = true
        };

        var domain = new
        {
            Mountains = context.Domain.Mountains.Select(x => new MountainLite(x)).ToList(),
            Classifications = context.Domain.Classifications.Select(x => new ClassificationLite(x)).ToList(),
            Countries = context.Domain.Countries.Select(x => new CountryLite(x)).ToList(),
            Regions = context.Domain.Regions.Select(x => new RegionLite(x)).ToList(),
            Maps = context.Domain.Maps.Select(x => new MapLite(x)).ToList(),
        };

        var contents = JsonSerializer.Serialize(domain, options);
        File.AppendAllText(context.FileManager.OutputJson.FullName, contents);
    }

    protected override string GetSuccessMessage(Context context) => "Data written to file";
}