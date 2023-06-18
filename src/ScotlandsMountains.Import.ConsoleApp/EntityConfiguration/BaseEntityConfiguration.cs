namespace ScotlandsMountains.Import.ConsoleApp.EntityConfiguration;

public abstract class BaseEntityConfiguration<T> : IEntityTypeConfiguration<T> where T : Entity
{
    public virtual void Configure(EntityTypeBuilder<T> builder)
    {
        builder.Property(x => x.Id).ValueGeneratedOnAdd();
    }
}