namespace ScotlandsMountains.Data
{
    internal class ScotlandsMountainsContext : DbContext
    {
        private readonly FileInfo _file = new (@"C:\Users\Graham\Desktop\scotlands-mountains.db");

        public DbSet<Classification> Classifications { get; set; } = null!;
        
        public DbSet<Country> Countries { get; set; } = null!;
        
        public DbSet<Map> Maps { get; set; } = null!;
        
        public DbSet<Mountain> Mountains { get; set; } = null!;
        
        public DbSet<Region> Regions { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder options)
            => options.UseSqlite($"Data Source={_file}");

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Mountain>()
                .Property(x => x.Aliases)
                .HasConversion(
                    x => string.Join('|', x),
                    x => x.Split('|', StringSplitOptions.RemoveEmptyEntries).ToList());
        }
    }
}
