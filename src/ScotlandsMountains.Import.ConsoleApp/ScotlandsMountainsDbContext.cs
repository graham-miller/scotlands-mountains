namespace ScotlandsMountains.Import.ConsoleApp;

public class ScotlandsMountainsDbContext : DbContext
{
    private readonly FileInfo _dbFile;

    public ScotlandsMountainsDbContext(FileInfo dbFile)
    {
        _dbFile = dbFile;
    }

    public DbSet<Classification> Classifications { get; set; } = null!;
        
    public DbSet<Country> Countries { get; set; } = null!;
        
    public DbSet<Map> Maps { get; set; } = null!;
        
    public DbSet<Mountain> Mountains { get; set; } = null!;
        
    public DbSet<Region> Regions { get; set; } = null!;

    protected override void OnConfiguring(DbContextOptionsBuilder options)
    {
        options
            .UseSqlite($"Data Source={_dbFile.FullName}");
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);
        modelBuilder.ApplyConfigurationsFromAssembly(typeof(ScotlandsMountainsDbContext).Assembly);

        foreach (var entity in modelBuilder.Model.GetEntityTypes())
        {
            foreach (var property in entity.GetProperties())
            {
                property.SetColumnName(property.GetColumnName().Camelize());
            }
        }
    }
}