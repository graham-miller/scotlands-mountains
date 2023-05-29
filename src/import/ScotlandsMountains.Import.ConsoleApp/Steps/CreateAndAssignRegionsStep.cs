using Region = ScotlandsMountains.Import.ConsoleApp.Models.Region;

namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal class CreateAndAssignRegionsStep : Step
{
    protected override void SetStatus(Context context)
    {
        context.StatusReporter.SetStatus("Create and assign regions...");
    }

    protected override void Implementation(Context context)
    {
        var lookup = context.DobihRecords
            .Select(x => x.Region)
            .Distinct()
            .Select(raw =>
            {
                var split = raw.Split(':');
                var code = split[0].Trim();
                var name = split[1].Trim();

                // ReSharper disable once ConvertIfStatementToSwitchStatement
                // ReSharper disable StringLiteralTypo
                if (code == "08A") name = "Cairngorms (west)";
                if (code == "08B") name = "Cairngorms (east)";
                // ReSharper restore StringLiteralTypo

                return new { Code = code, Name = name };
            }).ToDictionary(
                k => k.Code,
                v => new Region
                {
                    Id = context.IdGenerator.Next,
                    Name = v.Name,
                    Code = v.Code
                });

        context.Regions = lookup.Values.ToList();

        foreach (var item in context.MountainsByDobihId.Values)
        {
            var code = item.Record.Region.Split(':')[0].Trim();
            item.Mountain.Region = lookup[code];
        }
    }

    protected override void LogSuccess(Context context)
    {
        context.StatusReporter.LogSuccess($"Created and assigned {context.Regions.Count:#,##0} regions");
    }
}