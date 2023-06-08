namespace ScotlandsMountains.App;

public partial class App : Application
{
    public App(AppShell page)
    {
        InitializeComponent();

        MainPage = page;
    }
}