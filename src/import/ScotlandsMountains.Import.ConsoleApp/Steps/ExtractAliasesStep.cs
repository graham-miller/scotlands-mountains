namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal class ExtractAliasesStep : Step
{
    protected override string GetStatusMessage(Context context) => "Extracting aliases...";

    protected override void Implementation(Context context)
    {
        foreach (var item in context.MountainsByDobihId.Values)
        {
            var (name, aliases) = ExtractNameAndAliases(item.Mountain.Name);

            item.Mountain.Name = name;
            item.Mountain.Aliases = aliases;
        }
    }

    protected override string GetSuccessMessage(Context context) => "Aliases extracted";

    private static (string, IList<string>) ExtractNameAndAliases(string originalName)
    {
        var name = string.Empty;
        var aliases = new List<string>();

        var inAlias = false;
        var alias = string.Empty;

        foreach (var letter in originalName)
        {
            if (inAlias)
            {
                if (letter == ']')
                {
                    aliases.Add(alias);
                    inAlias = false;
                }
                else
                {
                    alias += letter;
                }
            }
            else
            {

                if (letter == '[')
                {
                    alias = string.Empty;
                    inAlias = true;
                }
                else
                {
                    name += letter;
                }
            }
        }

        return (name.Trim().Replace("  ", ""), aliases.Select(x => x.Trim()).ToList());
    }
}