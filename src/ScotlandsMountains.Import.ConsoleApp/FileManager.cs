namespace ScotlandsMountains.Import.ConsoleApp;

public class FileManager
{
    public FileManager()
    {
        HillCsv = new FileInfo(Path.Join(GetDataFolderPath(), "hillcsv.zip"));
        OutputJson = new FileInfo(Path.Join(GetDataFolderPath(), "scotlands-mountains.json"));
        OutputDb = new FileInfo(Path.Join(GetDataFolderPath(), "scotlands-mountains.db"));
        AppResourcesRawDb = new FileInfo(Path.Join(GetAppResourcesRawFolderPath(), @"scotlands-mountains.db"));
    }

    public virtual FileInfo HillCsv { get; }

    public virtual FileInfo OutputJson { get; }

    public virtual FileInfo OutputDb { get; }
    
    public virtual FileInfo AppResourcesRawDb { get; }

    private string GetDataFolderPath()
    {
        return Path.Join(GetRootFolderPath(), "data");
    }

    private string GetAppResourcesRawFolderPath()
    {
        return Path.Join(GetRootFolderPath(), @"src\ScotlandsMountains.App\Resources\Raw");
    }

    private string GetRootFolderPath()
    {
        var dir = new FileInfo(GetType().Assembly.Location).Directory;

        while (!dir!.FullName.EndsWith("scotlands-mountains"))
            dir = dir.Parent;

        return dir.FullName;
    }
}