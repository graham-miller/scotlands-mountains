namespace ScotlandsMountains.Data;

internal class ScotlandsMountainsContext : DbContext
{
    public DbSet<Classification> Classifications { get; set; } = null!;
        
    public DbSet<Country> Countries { get; set; } = null!;
        
    public DbSet<Map> Maps { get; set; } = null!;
        
    public DbSet<Mountain> Mountains { get; set; } = null!;
        
    public DbSet<Region> Regions { get; set; } = null!;

    protected override void OnConfiguring(DbContextOptionsBuilder options)
    {
        options.UseSqlite($"Data Source={new FileManager().OutputDb}");
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.ApplyConfigurationsFromAssembly(typeof(ScotlandsMountainsContext).Assembly);
    }
}
