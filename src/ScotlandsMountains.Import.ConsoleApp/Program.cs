Console.OutputEncoding = Encoding.UTF8;
Console.InputEncoding = Encoding.UTF8;

var steps = new List<Step>
{
    new ReadHillCsvZipStep(),
    new CreateMapsStep(),
    new CreateCountriesStep(),
    new CreateMountainsStep(),
    new AssignParentMountainStep(),
    new CreateAndAssignClassificationsStep(),
    new CreateAndAssignRegionsStep(),
    new AssignMapsStep(),
    new CreateAndPopulateDatabaseStep(),
    //new CopyDatabaseToAppAssetsStep()
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
            new FileManager(),
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