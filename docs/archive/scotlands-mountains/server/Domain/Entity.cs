namespace ScotlandsMountains.Domain
{
    public class Entity
    {
        public string Id { get; set; }

        public string Name { get; set; }

        public string DobihId { get; set; }

        public override bool Equals(object obj)
        {
            if (obj == null || GetType() != obj.GetType()) return false;
            
            var other = (Entity) obj;
            return Id.Equals(other.Id);
        }

        public override int GetHashCode()
        {
            return Id.GetHashCode();
        }

        public override string ToString()
        {
            return Name;
        }
    }
}