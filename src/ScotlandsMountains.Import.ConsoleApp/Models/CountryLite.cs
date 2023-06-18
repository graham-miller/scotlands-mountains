namespace ScotlandsMountains.Import.ConsoleApp.Models;

public class CountryLite
{
    public CountryLite(Country country)
    {
        Name = country.Name;
        Mountains = country.Mountains.Select(x => x.ToString()).ToList();
    }

    public string Name { get; }

    public List<string> Mountains { get; }
}