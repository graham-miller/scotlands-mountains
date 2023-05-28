﻿Console.OutputEncoding = Encoding.UTF8;
Console.InputEncoding = Encoding.UTF8;

var hillCsv = new FileInfo(@"C:\Repos\scotlands-mountains\data\hillcsv.zip");

var steps = new List<Step>
{
    new ReadHillCsvZipStep(),
    new CreateMountainsStep(),
    new AssignParentMountainStep(),
    new CreateClassificationsStep(),
    new AssignClassificationsStep(),
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
        var context = new Context(
            hillCsv,
            new IdGenerator(),
            new StatusReporter(statusContext, AnsiConsole.Console),
            new ClassificationData());

        foreach (var step in steps)
        {
            step.Execute(context);
        }

        AnsiConsole.MarkupLine(StatusReporter.GreenCheck + " Import completed successfully");
    });

AnsiConsole.MarkupLine(string.Empty);
AnsiConsole.MarkupLine("Press any key to exit");
AnsiConsole.Console.Input.ReadKey(false);

