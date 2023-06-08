namespace ScotlandsMountains.App;

public static class MauiProgram
{
    public static MauiApp CreateMauiApp()
    {
        var builder = MauiApp.CreateBuilder();
        builder
            .UseMauiApp<App>()
            .ConfigureFonts(fonts =>
            {
                fonts.AddFont("OpenSans-Regular.ttf", "OpenSansRegular");
                fonts.AddFont("OpenSans-Semibold.ttf", "OpenSansSemibold");
            });

        builder.Services.AddSingleton<AppShell>();
        builder.Services.AddSingleton<MainPage>();
        builder.Services.AddSingleton<MountainsViewModel>();

        ConfigureDatabase(builder);

#if DEBUG
        builder.Logging.AddDebug();
#endif

        return builder.Build();
    }

    private static void ConfigureDatabase(MauiAppBuilder builder)
    {
        const string databaseName = "scotlands-mountains.db";
        
        var stream = FileSystem.OpenAppPackageFileAsync(databaseName).Result;
        using var memoryStream = new MemoryStream();
        stream.CopyTo(memoryStream);

        var databasePath = Path.Combine(FileSystem.AppDataDirectory, databaseName);
        File.WriteAllBytes(databasePath, memoryStream.ToArray());

        builder.Services.AddTransient(_ => new ScotlandsMountainsDbContext(new FileInfo(databasePath)));
    }
}