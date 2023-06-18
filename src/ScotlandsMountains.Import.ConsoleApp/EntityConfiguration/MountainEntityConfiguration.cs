namespace ScotlandsMountains.Import.ConsoleApp.EntityConfiguration;

public class MountainEntityConfiguration : BaseEntityConfiguration<Mountain>
{
    public override void Configure(EntityTypeBuilder<Mountain> builder)
    {
        base.Configure(builder);
        builder
            .HasMany(x => x.Classifications)
            .WithMany(x => x.Mountains)
            .UsingEntity(x => x.ToTable($"{nameof(Mountain)}{nameof(Classification)}".Pluralize()));
        builder
            .HasMany(x => x.Countries)
            .WithMany(x => x.Mountains)
            .UsingEntity(x => x.ToTable($"{nameof(Mountain)}{nameof(Country)}".Pluralize()));
        builder
            .HasMany(x => x.Maps)
            .WithMany(x => x.Mountains)
            .UsingEntity(x => x.ToTable($"{nameof(Mountain)}{nameof(Map)}".Pluralize()));
    }
}