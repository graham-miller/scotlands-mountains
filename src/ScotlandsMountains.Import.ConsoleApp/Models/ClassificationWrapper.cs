namespace ScotlandsMountains.Import.ConsoleApp.Models
{
    internal class ClassificationWrapper
    {
        public ClassificationWrapper(ClassificationInfo info, string id)
        {
            Info = info;

            Value = new Classification
            {
                Id = id,
                Name = info.Name,
                NameSingular = info.NameSingular,
                Description = info.Description,
            };
        }

        public ClassificationInfo Info { get; }

        public Classification Value { get; }
    }
}
