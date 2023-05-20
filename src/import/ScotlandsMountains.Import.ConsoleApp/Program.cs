Console.OutputEncoding = Encoding.UTF8;
Console.InputEncoding = Encoding.UTF8;

const string hillCsvPath = @"C:\Repos\scotlands-mountains\data\hillcsv.zip";

var steps = new List<Step>
{
    new ReadHillCsvZipStep(),
    new CreateMountainsStep()
};

AnsiConsole.Write(
    new FigletText("Scotland's Mountains")
        .Centered()
        .Color(Color.Purple));

AnsiConsole.Status()
    .Spinner(Spinner.Known.Dots2)
    .SpinnerStyle(Style.Parse("yellow"))
    .Start("Initializing...", statusContext =>
    {
        var context = new Context(hillCsvPath, new IdGenerator(), new StatusReporter(statusContext, AnsiConsole.Console));

        foreach (var step in steps)
        {
            step.Execute(context);
        }

        AnsiConsole.MarkupLine(StatusReporter.GreenCheck + " Import completed successfully");
    });

AnsiConsole.MarkupLine(string.Empty);
AnsiConsole.MarkupLine("Press any key to exit");
AnsiConsole.Console.Input.ReadKey(false);

