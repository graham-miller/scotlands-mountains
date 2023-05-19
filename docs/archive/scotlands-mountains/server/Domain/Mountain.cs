using System;
using System.Collections.Generic;
using System.Text;

namespace ScotlandsMountains.Domain
{
    public class Mountain : Entity
    {
        public IList<string> Aliases { get; set; } = new List<string>();
        public Section Section { get; set; }
        public List<Classification> Classifications { get; set; } = new List<Classification>();
        public decimal Height { get; set; }
        public decimal Latitude { get; set; }
        public decimal Longitude { get; set; }
        public string GridRef { get; set; }
        public Prominence Prominence { get; set; } = new Prominence();
        public Summit Summit { get; set; }
        public string Island { get; set; }
        public County County { get; set; }
        public List<Map> Maps { get; set; } = new List<Map>();
    }

    public class Prominence
    {
        public decimal Height { get; set; }
        public string From { get; set; }
        public decimal FromHeight { get; set; }
    }

    public class Summit
    {
        public string Description { get; set; }
        public string Notes { get; set; }
    }
}
