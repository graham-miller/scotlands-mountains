namespace ScotlandsMountains.Import.ConsoleApp.Models
{
    internal class MountainWrapper
    {
        public MountainWrapper(DobihRecord record, string id, Context context)
        {
            Dobih = record;

            var (name, aliases) = ExtractNameAndAliases(record.Name);

            Value = new Mountain
            {
                Id = id,
                Name = name,
                Aliases = aliases,
                Latitude = record.Latitude,
                Longitude = record.Longitude,
                GridRef = FormatGridRef(record.GridRefXY),
                Height = record.Metres,
                Feature = FormatAsSentence(record.Feature),
                Observations = FormatAsSentence(record.Observations),
                Drop = record.Drop,
                Col = FormatGridRef(record.ColGridRef),
                ColHeight = record.ColHeight,
                Countries = record.Country.Select(x => context.CountriesByInitial[x]).ToList(),
                DobihId = record.Number
            };
        }

        public DobihRecord Dobih { get; }

        public Mountain Value { get; }

        private static (string, List<string>) ExtractNameAndAliases(string raw)
        {
            var name = string.Empty;
            var aliases = new List<string>();

            var inAlias = false;
            var alias = string.Empty;

            foreach (var letter in raw)
            {
                if (inAlias)
                {
                    if (letter == ']')
                    {
                        aliases.Add(alias);
                        inAlias = false;
                    }
                    else
                    {
                        alias += letter;
                    }
                }
                else
                {

                    if (letter == '[')
                    {
                        alias = string.Empty;
                        inAlias = true;
                    }
                    else
                    {
                        name += letter;
                    }
                }
            }

            return (name.Trim().Replace("  ", ""), aliases.Select(x => x.Trim()).ToList());
        }

        private static readonly Regex RawGridRefRegex = new("^[A-Z]{1,2}[0-9 ]{6,12}$");

        private static string FormatGridRef(string raw)
        {

            if (string.IsNullOrEmpty(raw) || !RawGridRefRegex.IsMatch(raw)) return raw;

            var withoutSpaces = string.Concat(raw.Where(x => x != ' '));
            var letters = string.Concat(withoutSpaces.Where(char.IsLetter));
            var numbers = string.Concat(withoutSpaces.Where(char.IsNumber));

            if (numbers.Length % 2 != 0) return raw;

            // ReSharper disable once ReplaceSubstringWithRangeIndexer
            var easting = numbers.Substring(0, numbers.Length / 2);
            var northing = numbers.Substring(numbers.Length / 2, numbers.Length / 2);

            easting = easting.PadRight(5, '0');
            northing = northing.PadRight(5, '0');

            return $"{letters} {easting} {northing}";
        }

        private static string? FormatAsSentence(string? raw)
        {
            if (string.IsNullOrWhiteSpace(raw)) return null;

            var formatted = char.ToUpper(raw.First()) + string.Concat(raw.Skip(1));

            if (formatted.Last() == '.') return formatted;

            return formatted + '.';
        }
    }
}