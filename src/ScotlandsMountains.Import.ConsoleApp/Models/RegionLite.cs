namespace ScotlandsMountains.Import.ConsoleApp.Models;

public class RegionLite
{
    public RegionLite(Region region)
    {
        Name = region.Name;
        Code = region.Code;
        Mountains = region.Mountains.Select(x => x.ToString()).ToList();
    }

    public string Name { get; }

    public string Code { get; }

    public List<string> Mountains { get; }
}