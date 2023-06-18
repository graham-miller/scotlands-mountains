using Microsoft.EntityFrameworkCore.ChangeTracking;

namespace ScotlandsMountains.Import.ConsoleApp.EntityConfiguration;

public class MountainEntityConfiguration : IEntityTypeConfiguration<Mountain>
{
    public void Configure(EntityTypeBuilder<Mountain> builder)
    {
        var aliasesComparer = new ValueComparer<List<string>>(
            (c1, c2) => c1!.SequenceEqual(c2!),
            c => c.Aggregate(0, (a, v) => HashCode.Combine(a, v.GetHashCode())),
            c => c.ToList());
        
        builder
            .Property(x => x.Aliases)
            .HasConversion(
                x => string.Join('|', x),
                x => x.Split('|', StringSplitOptions.RemoveEmptyEntries).ToList())
            .Metadata
            .SetValueComparer(aliasesComparer);
    }
}