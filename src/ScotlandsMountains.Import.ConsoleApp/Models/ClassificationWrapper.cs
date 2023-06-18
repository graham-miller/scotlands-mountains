namespace ScotlandsMountains.Import.ConsoleApp.Models;

internal class ClassificationWrapper
{
    public ClassificationWrapper(ClassificationInfo info)
    {
        Info = info;

        Value = new Classification
        {
            Name = info.Name,
            DisplayOrder = info.DisplayOrder,
            IsActive = info.IsActive,
            NameSingular = info.NameSingular,
            Description = info.Description,
        };
    }

    public ClassificationInfo Info { get; }

    public Classification Value { get; }
}