namespace ScotlandsMountains.Import.ConsoleApp.Entities
{
    public class MapSeries : Entity
    {
        public static class Names
        {
            public const string Explorer = "Explorer";
            public const string Landranger = "Landranger";
        }

        public MapPublisher Publisher { get; set; } = null!;

        public double Scale { get; set; }

        public List<Map> Maps { get; set; } = new List<Map>();
    }
}
