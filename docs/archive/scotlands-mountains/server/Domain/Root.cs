using System.Collections.Generic;

namespace ScotlandsMountains.Domain
{
    public class Root
    {
        public IList<Classification> Classifications { get; set; }

        public IList<Section> Sections { get; set; }
        
        public IList<County> Counties { get; set; }
        
        public IList<Map> Maps { get; set; }

        public IList<Mountain> Mountains { get; set; }
    }
}
