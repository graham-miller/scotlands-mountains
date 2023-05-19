using ScotlandsMountains.Import.ConsoleApp.Dobih;
using Spectre.Console;

AnsiConsole.Write(
    new FigletText("Scotland's Mountains")
        .Centered()
        .Color(Color.Green));

var records = Parser.Parse(@"C:\Repos\scotlands-mountains\data\hillcsv.zip");

Console.WriteLine($"Parsed {records.Count:#,##0}.");