namespace ScotlandsMountains.Import.ConsoleApp.Models
{
    internal class MountainRecordWrapper
    {
        public MountainRecordWrapper(DobihRecord record, string id, Context context)
        {
            Record = record;

            Mountain = new Mountain
            {
                Id = id,
                Name = record.Name,
                Latitude = record.Latitude,
                Longitude = record.Longitude,
                GridRef = record.GridRefXY.FormatAsGridRef(),
                Height = record.Metres,
                Feature = record.Feature,
                Observations = record.Observations,
                Drop = record.Drop,
                Col = record.ColGridRef.FormatAsGridRef(),
                ColHeight = record.ColHeight,
                Countries = record.Country.Select(x => context.CountriesByInitial[x].ToSummary()).ToList(),
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
