namespace ScotlandsMountains.Import.ConsoleApp.EntityConfiguration;

public class AliasEntityConfiguration : BaseEntityConfiguration<Alias>
{
    public override void Configure(EntityTypeBuilder<Alias> builder)
    {
        builder.ToTable(nameof(Alias).Pluralize());
        base.Configure(builder);
    }
}