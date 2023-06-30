namespace ScotlandsMountains.Import.ConsoleApp.Steps;

internal class CreateMapsStep : Step
{
    protected override string GetStatusMessage(Context context) => "Create maps...";

    protected override void Implementation(Context context)
    {
        var publisher = new MapPublisher
        {
            Name = "Ordnance Survey"
        };

        var explorer = new MapSeries
        {
            Publisher = publisher,
            Name = MapSeries.Names.Explorer,
            Scale = 1 / 25_000d
        };
        publisher.Series.Add(explorer);

        var landranger = new MapSeries
        {
            Publisher = publisher,
            Name = MapSeries.Names.Landranger,
            Scale = 1 / 50_000d
        };
        publisher.Series.Add(landranger);

        ReadMaps(context.FileManager.ExplorerTxt.FullName, explorer);
        ReadMaps(context.FileManager.LandrangerTxt.FullName, landranger);

        context.MapPublisher = publisher;
    }

    private static void ReadMaps(string path, MapSeries series)
    {
        var lines = File.ReadAllLines(path);
        var position = 0;

        while (position < lines.Length)
        {
            var words = lines[position].Split(' ');

            while (!IsIsbn(words.Last()))
            {
                position++;
                words = words.Concat(lines[position].Split(' ')).ToArray();
            }

            var code = words.First();
            var name = string.Join(' ', words.Skip(1).SkipLast(1));
            var isbn = words.Last();

            series.Maps.Add(new Map
            {
                Code = code,
                Name = name,
                Isbn = isbn,
                Series = series
            });

            position++;
        }
    }

    private static bool IsIsbn(string word)
    {
        return word.Length == 13 && word.All(char.IsDigit);
    }

    protected override string GetSuccessMessage(Context context) => $"Created {context.MapPublisher.Series.Sum(x => x.Maps.Count):#,##0} maps";
}