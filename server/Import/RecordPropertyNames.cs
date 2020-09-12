using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;
using Humanizer;

namespace ScotlandsMountains.Import
{
    internal static class RecordPropertyNames
    {
        public static void Generate(string[] headerRecord)
        {
            var isClassification = false;

            foreach(var header in headerRecord)
            {
                string classification = null;
                string property;

                if (header == "Ma") isClassification = true;



                if (isClassification)
                {
                    if (header.StartsWith("s")) classification = $"Sub {ClassificationLookup[header.Substring(1)]}";
                    else if (header.StartsWith("x")) classification = $"Deleted {ClassificationLookup[header.Substring(1)]}";
                    else if (header.EndsWith("=")) classification = $"{ClassificationLookup[header.Substring(0, header.Length - 1)]} twin";
                    else classification = $"{ClassificationLookup[header]}";

                    property = $"Is {classification}".Replace("(", "").Replace(")", "").Dehumanize();
                }
                else if (header == "_Section")
                {
                    property = "SectionNumber";
                }
                else if (header == "Map 1:50k")
                {
                    property = "Map1To50k";
                }
                else if (header == "Map 1:25k")
                {
                    property = "Map1To25k";
                }
                else
                {
                    property = header.Dehumanize();
                }

                Debug.WriteLine($"[Name(\"{header}\")]");
                if (classification != null) Debug.WriteLine($"[ClassificationName(\"{classification}\")]");
                Debug.WriteLine($"public {(isClassification ? "bool" : "string")} {property} {{ get; set; }}");
                Debug.WriteLine("");
            }
        }

        private static readonly IDictionary<string, string> ClassificationLookup = new Dictionary<string, string>
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

        internal class Name
        {
            public string ColumnName { get; set; }
            public string PropertyName { get; set; }
        }
    }
}
