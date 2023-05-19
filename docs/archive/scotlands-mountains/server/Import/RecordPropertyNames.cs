using System.Diagnostics;
using Humanizer;

namespace ScotlandsMountains.Import
{
    internal static class RecordPropertyNames
    {
        public static void Generate(string[] headerRecord)
        {
            var classificationLookup = new ClassificationNameLookup();
            var isClassification = false;

            foreach(var header in headerRecord)
            {
                string classification = null;
                string property;

                if (header == "Ma") isClassification = true;

                if (isClassification)
                {
                    classification = classificationLookup[header];
                    property = $"Is {classification}".Replace("(", "").Replace(")", "").Dehumanize();
                }
                else
                {
                    property = header switch
                    {
                        "_Section" => "SectionNumber",
                        "Map 1:50k" => "Map1To50k",
                        "Map 1:25k" => "Map1To25k",
                        _ => header.Dehumanize()
                    };
                }

                Debug.WriteLine($"[Name(\"{header}\")]");
                if (classification != null) Debug.WriteLine($"[ClassificationName(\"{classification}\")]");
                Debug.WriteLine($"public {(isClassification ? "bool" : "string")} {property} {{ get; set; }}");
                Debug.WriteLine("");
            }
        }
    }
}
