namespace ScotlandsMountains.Import.ConsoleApp;

internal class IdGenerator
{
    private const string CharacterSet = "abcdefghjkmnpqrstuvwxyzABCDEFGHJKMNPQRSTUVWXYZ23456789";

    private readonly GenerationOptions _options;
    private readonly HashSet<string> _previousIds = new();

    public IdGenerator()
    {
        ShortId.SetCharacters(CharacterSet);
        _options = new GenerationOptions(false, false, 10);
    }

    public virtual string Next()
    {
        var id = ShortId.Generate(_options);

        if (!_previousIds.Add(id)) throw new Exception("ID collision");

        return id;
    }
}