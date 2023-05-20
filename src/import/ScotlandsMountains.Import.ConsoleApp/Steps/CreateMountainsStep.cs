namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal class CreateMountainsStep : Step
{
    public override void Execute(Context context)
    {
        context.StatusReporter.SetStatus("Creating mountains...");

        context.Mountains = context.DobihRecords
            .ToDictionary(
                x => x.Number,
                x => CreateMountain(x, context.IdGenerator.Next));

        context.StatusReporter.LogSuccess($"Created {context.Mountains.Count:#,##0} mountains");
    }

    private static Mountain CreateMountain(Record record, string id)
    {
        return new Mountain
        {
            Id = id,
            Name = record.Name,
            Latitude = record.Latitude,
            Longitude = record.Longitude,
            GridRef = record.GridRefXY,
            Height = record.Metres,
            Feature = record.Feature,
            Observations = record.Observations,
            Drop = record.Drop,
            Col = record.ColGridRef,
            ColHeight = record.ColHeight,
            DobihId = record.Number
        };
    }
}