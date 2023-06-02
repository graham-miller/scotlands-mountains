namespace ScotlandsMountains.Import.ConsoleApp.Models
{
    internal class ClassificationWrapper
    {
        public ClassificationWrapper(ClassificationInfo info, string id)
        {
            Info = info;

            Classification = new Classification
            {
                Id = id,
                Name = info.Name,
                NameSingular = info.NameSingular,
                Description = info.Description,
            };

            Summary = Classification.ToSummary();
        }

        public ClassificationInfo Info { get; }

        public Classification Classification { get; }

        public Entity Summary { get; }
    }
}
