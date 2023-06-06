namespace ScotlandsMountains.Import.ConsoleApp.Models;

public class CountryLite
{
    public CountryLite(Country country)
    {
        Id = country.Id;
        Name = country.Name;
        Mountains = country.Mountains.Select(x => x.ToString()).ToList();
    }

    public string Id { get; }

    public string Name { get; }

    public List<string> Mountains { get; }
}