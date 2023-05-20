namespace ScotlandsMountains.Import.ConsoleApp;

internal class IdGenerator
{
    private const string CharacterSet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

    private readonly GenerationOptions _options;

    public IdGenerator()
    {
        ShortId.SetCharacters(CharacterSet);
        _options = new GenerationOptions(false, false, 10);
    }

    public virtual string Next => ShortId.Generate(_options);
}