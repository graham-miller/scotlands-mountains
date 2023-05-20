using ScotlandsMountains.Import.ConsoleApp.Extensions;

Console.OutputEncoding = Encoding.UTF8;
Console.InputEncoding = Encoding.UTF8;

const string hillCsvPath = @"C:\Repos\scotlands-mountains\data\hillcsv.zip";
var hillCsv = new FileInfo(hillCsvPath);

AnsiConsole.Write(
    new FigletText("Scotland's Mountains")
        .Centered()
        .Color(Color.Purple));

AnsiConsole.Status()
    .Spinner(Spinner.Known.Dots2)
    .SpinnerStyle(Style.Parse("yellow"))
    .Start("Initializing...", ctx =>
    {
        ctx.Status($"Loading {hillCsv.Name}...");
        var records = Parser.Parse(hillCsvPath);
        AnsiConsole.Console.Success($"Loaded {records.Count:#,##0} records from {hillCsv.Name}");

        ctx.Status("Creating mountains...");
        AnsiConsole.Console.Success("21,296 mountains created");

        ctx.Status("Creating countries...");
        AnsiConsole.Console.Success("5 countries created");

        AnsiConsole.Console.Success("Import completed successfully");
    });

AnsiConsole.MarkupLine(string.Empty);
AnsiConsole.MarkupLine("Press any key to exit");
AnsiConsole.Console.Input.ReadKey(false);
