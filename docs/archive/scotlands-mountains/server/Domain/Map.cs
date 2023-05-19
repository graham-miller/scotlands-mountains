namespace ScotlandsMountains.Domain
{
    public class Map : Entity
    {
        public const decimal Scale1To25000 = 0.00004M;
        public const decimal Scale1To50000 = 0.00002M;

        public string Code { get; set; }
        public string Series { get; set; }
        public string Publisher { get; set; }
        public decimal Scale { get; set; }
    }
}
