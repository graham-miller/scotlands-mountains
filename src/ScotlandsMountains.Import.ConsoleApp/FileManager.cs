namespace ScotlandsMountains.Import.ConsoleApp;

public class FileManager
{
    public FileManager()
    {
        HillCsv = new (Path.Join(GetDataFolderPath(), "hillcsv.zip"));
        OutputJson = new (Path.Join(GetDataFolderPath(), "scotlands-mountains.json"));
        OutputDb = new (Path.Join(GetDataFolderPath(), "scotlands-mountains.db"));
    }

    public virtual FileInfo HillCsv { get; }

    public virtual FileInfo OutputJson { get; }

    public virtual FileInfo OutputDb { get; }

    private string GetDataFolderPath()
    {
        var dir = new FileInfo(GetType().Assembly.Location).Directory;

        while (!dir!.FullName.EndsWith("scotlands-mountains"))
            dir = dir.Parent;

        dir = dir.GetDirectories("data").Single();

        return dir.FullName;
    }
}