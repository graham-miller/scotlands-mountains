namespace ScotlandsMountains.Import.ConsoleApp;

public class FileManager
{
    public FileManager()
    {
        HillCsv = new FileInfo(Path.Join(GetDataFolderPath(), "hillcsv.zip"));
        ExplorerTxt = new FileInfo(Path.Join(GetDataFolderPath(), "explorer.txt"));
        LandrangerTxt = new FileInfo(Path.Join(GetDataFolderPath(), "landranger.txt"));
        OutputDb = new FileInfo(Path.Join(GetDataFolderPath(), "scotlands_mountains.db"));
        AppAssetsDb = new FileInfo(Path.Join(GetAppAssetsFolderPath(), "scotlands_mountains.db"));
    }

    public virtual FileInfo HillCsv { get; }

    public virtual FileInfo ExplorerTxt { get; }

    public virtual FileInfo LandrangerTxt { get; }

    public virtual FileInfo OutputDb { get; }
    
    public virtual FileInfo AppAssetsDb { get; }

    private string GetDataFolderPath()
    {
        return Path.Join(GetRootFolderPath(), "data");
    }

    private string GetAppAssetsFolderPath()
    {
        return Path.Join(GetRootFolderPath(), @"src\scotlands_mountains_app\assets");
    }

    private string GetRootFolderPath()
    {
        var dir = new FileInfo(GetType().Assembly.Location).Directory;

        while (!dir!.FullName.EndsWith("scotlands-mountains"))
            dir = dir.Parent;

        return dir.FullName;
    }
}