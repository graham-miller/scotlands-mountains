namespace ScotlandsMountains.Domain
{
    public class Classification : Entity
    {
        public Classification() { }

        public Classification(
            string dobihId,
            string name,
            bool enabled,
            int order,
            string description)
        {
            DobihId = dobihId;
            Name = name;
            Enabled = enabled;
            Order = order;
            Description = description;
        }

        public bool Enabled { get; set; }
        public int Order { get; set; }
        public string Description { get; set; }
    }
}
