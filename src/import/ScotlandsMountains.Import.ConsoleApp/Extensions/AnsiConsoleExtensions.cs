namespace ScotlandsMountains.Import.ConsoleApp.Extensions;

internal static class AnsiConsoleExtensions
{
    public static void Success(this IAnsiConsole console, string value) =>
        console.MarkupLineInterpolated($"[lime]✓[/] {value}");
}