namespace ScotlandsMountains.Import.ConsoleApp.Models;

internal class RegionWrapper
{
    public RegionWrapper(string raw, string id)
    {
        var split = raw.Split(':');
        Code = split[0].Trim();
        var name = split[1].Trim();

        // ReSharper disable once ConvertIfStatementToSwitchStatement
        // ReSharper disable StringLiteralTypo
        if (Code == "08A") name = "Cairngorms (west)";
        if (Code == "08B") name = "Cairngorms (east)";
        // ReSharper restore StringLiteralTypo

        Value = new Region
        {
            Id = id,
            Name = name,
            Code = Code
        };
    }

    public string Code { get; }

    public Region Value { get; }
}