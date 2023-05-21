namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal class CreateMountainsStep : Step
{
    protected override void SetStatus(Context context)
    {
        context.StatusReporter.SetStatus("Creating mountains...");
    }

    protected override void Implementation(Context context)
    {
        context.Mountains = context.DobihRecords
            .ToDictionary(
                x => x.Number,
                x => CreateMountain(x, context.IdGenerator.Next));
    }

    protected override void LogSuccess(Context context)
    {
        context.StatusReporter.LogSuccess($"Created {context.Mountains.Count:#,##0} mountains");
    }

    private static Mountain CreateMountain(DobihRecord dobihRecord, string id)
    {
        return new Mountain
        {
            Id = id,
            Name = dobihRecord.Name,
            Latitude = dobihRecord.Latitude,
            Longitude = dobihRecord.Longitude,
            GridRef = dobihRecord.GridRefXY,
            Height = dobihRecord.Metres,
            Feature = dobihRecord.Feature,
            Observations = dobihRecord.Observations,
            Drop = dobihRecord.Drop,
            Col = dobihRecord.ColGridRef,
            ColHeight = dobihRecord.ColHeight,
            DobihId = dobihRecord.Number
        };
    }
}