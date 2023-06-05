Console.OutputEncoding = Encoding.UTF8;
Console.InputEncoding = Encoding.UTF8;

var hillCsv = new FileInfo(@"C:\Repos\scotlands-mountains\data\hillcsv.zip");
var outputJson = new FileInfo(@"C:\Users\Graham\Desktop\scotlands-mountains.json");
var outputDb = new FileInfo(@"C:\Users\Graham\Desktop\scotlands-mountains.db");

var steps = new List<Step>
{
    new ReadHillCsvZipStep(),
    new CreateCountriesStep(),
    new CreateMountainsStep(),
    new AssignParentMountainStep(),
    new CreateAndAssignClassificationsStep(),
    new CreateAndAssignRegionsStep(),
    new CreateAndAssignMapsStep(),
    new PrepareData(),
    new WriteDataToFileStep()
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
        var stopwatch = new Stopwatch();
        stopwatch.Start();

        var context = new Context(
            hillCsv,
            outputJson,
            new IdGenerator(),
            new StatusReporter(statusContext, AnsiConsole.Console),
            new ClassificationData());

        foreach (var step in steps)
        {
            step.Execute(context);
        }

        stopwatch.Stop();

        context.StatusReporter.LogSuccess($"Data preparation completed successfully [{stopwatch.Elapsed.Humanize()}]");
    });

AnsiConsole.MarkupLine(string.Empty);
AnsiConsole.MarkupLine("Press any key to exit");
AnsiConsole.Console.Input.ReadKey(false);

