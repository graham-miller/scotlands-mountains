namespace ScotlandsMountains.Import.ConsoleApp.Models;

public class MapLite
{
    public MapLite(Map map)
    {
        Name = map.Name;
        Code = map.Code;
        Scale = map.Scale;
        Mountains = map.Mountains.Select(x => x.ToString()).ToList();
    }

    public string Name { get; }

    public string Code { get; }

    public double Scale { get; }

    public List<string> Mountains { get; }
}