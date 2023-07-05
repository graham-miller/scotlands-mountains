// ReSharper disable StringLiteralTypo
namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal class FixMountainNamesStep : Step
{
    protected override string GetStatusMessage(Context context) => "Fixing mountain names...";

    protected override void Implementation(Context context)
    {
        var toBeUpdated = context.MountainsByDobihId.Values
            .Where(m => m.Value.Countries.Any(c => c.Name == "Scotland"))
            .Where(m => m.Value.Name.Contains(" - "))
            .Where(m => !m.Value.Name.EndsWith("Trig Point"))
            .Where(m => m.Value.Name != "Eileanan Chearabhaigh - West")
            .Where(m => !m.Value.Name.StartsWith("Sgurr Dearg"))
            .Select(m => new
            {
                first = m.Value.Name[..m.Value.Name.IndexOf(" - ", StringComparison.Ordinal)],
                second = m.Value.Name[(m.Value.Name.IndexOf(" - ", StringComparison.Ordinal)+3)..],
                Mountain = m.Value
            })
            .ToList();

        foreach (var item in toBeUpdated)
        {
            if (toBeUpdated.Count(x => x.first == item.first) > 0)
            {
                item.Mountain.Name = item.second;
                item.Mountain.Aliases.Add(new Alias {Name = item.first});
            }
            else
            {
                item.Mountain.Name = item.first;
                item.Mountain.Aliases.Add(new Alias { Name = item.second });
            }
        }

        var inPin = context.MountainsByDobihId.Values
            .Single(m => m.Value.Name == "Sgurr Dearg - Inaccessible Pinnacle");

        inPin.Value.Aliases.Add(new Alias { Name = "Inaccessible Pinnacle"});
        inPin.Value.Name = "Sgurr Dearg";

        /*
        SELECT
	        m.name,
	        SUBSTR(m.name, 0, INSTR(m.name, ' - ')),
	        SUBSTR(m.name, INSTR(m.name, ' - ') + 3),
	        *
        FROM Mountains m
        INNER JOIN MountainCountries mc ON m.id = mc.mountainsId
        INNER JOIN Countries c ON mc.countriesId = c.id
        WHERE c.name = 'Scotland'
        AND m.name LIKE '% - %'
        AND m.name NOT LIKE '% - Trig Point'
        AND m.name <> 'Eileanan Chearabhaigh - West'
        AND m.name NOT LIKE 'Sgurr Dearg%'
        ORDER BY SUBSTR(m.name, 0, INSTR(m.name, ' - '))
        */
    }

    protected override string GetSuccessMessage(Context context) => "Fixed mountain names";
}