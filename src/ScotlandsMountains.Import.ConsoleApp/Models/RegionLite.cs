namespace ScotlandsMountains.Import.ConsoleApp.Models;

public class RegionLite
{
    public RegionLite(Region region)
    {
        Id = region.Id;
        Name = region.Name;
        Code = region.Code;
        Mountains = region.Mountains.Select(x => x.ToString()).ToList();
    }

    public string Id { get; }

    public string Name { get; }

    public string Code { get; }

    public List<string> Mountains { get; }
}