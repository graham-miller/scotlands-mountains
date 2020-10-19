using System.Collections.Generic;

namespace ScotlandsMountains.Import
{
    internal class ClassificationNameLookup
    {
        public string this[string key]
        {
            get
            {
                if (key.StartsWith("s")) return $"Sub {_lookup[key.Substring(1)]}";
                if (key.StartsWith("x")) return $"Deleted {_lookup[key.Substring(1)]}";
                if (key.EndsWith("=")) return $"{_lookup[key.Substring(0, key.Length - 1)]} twin";
                return $"{_lookup[key]}";
            }
        }

        private readonly IDictionary<string, string> _lookup = new Dictionary<string, string>
        {
            {"Ma", "Marilyn"},
            {"Hu", "HuMP"},
            {"Sim", "Simm"},
            {"5", "Dodd"},
            {"M", "Munro"},
            {"MT", "Munro Top"},
            {"F", "Furth"},
            {"C", "Corbett"},
            {"G", "Graham"},
            {"D", "Donald"},
            {"DT", "Donald Top"},
            {"Hew", "Hewitt"},
            {"N", "Nuttall"},
            {"Dew", "Dewey"},
            {"DDew", "Donald Dewey"},
            {"HF", "Highland Five"},
            {"4", "400m to 499m TuMP"},
            {"3", "300m to 399m TuMP"},
            {"2", "200m to 299m TuMP"},
            {"1", "100m to 199m TuMP"},
            {"0", "0m to 99m TuMP"},
            {"W", "Wainwright"},
            {"WO", "Wainwright outlying fell"},
            {"B", "Birkett"},
            {"Sy", "Synge"},
            {"Fel", "Fellranger"},
            {"CoH", "County Top – historic (pre-1974)"},
            {"CoA", "County Top – administrative (1974 to mid-1990s)"},
            {"CoU", "County Top – current county or unitary authority"},
            {"CoL", "County Top – current London borough"},
            {"SIB", "Significant island of Britain"},
            {"Dil", "Dillon"},
            {"A", "Arderin"},
            {"VL", "Vandeleur-Lynam"},
            {"MDew", "Myrddyn Dewey"},
            {"O", "Other list"},
            {"Un", "Unclassified"},
            {"Tu", "Tump"},
            {"Mur", "Murdo"},
            {"CT", "Corbett Top"},
            {"GT", "Graham Top"},
            {"BL", "Buxton & Lewis"},
            {"Bg", "Bridge"},
            {"T100", "Trail 100"},
            {"Y", "Yeaman"},
            {"Cm", "Clem"},
            {"Ca", "Carn"},
            {"Bin", "Binnion"}
        };
    }
}
