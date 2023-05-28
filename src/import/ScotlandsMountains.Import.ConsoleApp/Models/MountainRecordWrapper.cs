namespace ScotlandsMountains.Import.ConsoleApp.Models
{
    internal class MountainRecordWrapper
    {
        public MountainRecordWrapper(DobihRecord record, string id)
        {
            Record = record;

            Mountain = new Mountain
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

        public DobihRecord Record { get; }

        public Mountain Mountain { get; }

        private MountainSummary? _summary;
        public MountainSummary Summary
        {
            get { return _summary ??= Mountain.ToSummary(); }
        }
    }
}
