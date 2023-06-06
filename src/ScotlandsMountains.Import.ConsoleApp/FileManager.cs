using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ScotlandsMountains.Import.ConsoleApp
{
    internal class FileManager
    {
        public virtual FileInfo HillCsv => new FileInfo(Path.Join(GetDataFolderPath(), "hillcsv.zip"));

        public virtual FileInfo OutputJson => new FileInfo(Path.Join(GetDataFolderPath(), "scotlands-mountains.json"));

        public virtual FileInfo OutputDb => new FileInfo(Path.Join(GetDataFolderPath(), "scotlands-mountains.db"));

        private string GetDataFolderPath()
        {
            var dir = new FileInfo(GetType().Assembly.Location).Directory;

            while (!dir.FullName.EndsWith("scotlands-mountains"))
                dir = dir.Parent;

            dir = dir.GetDirectories("data").Single();

            return dir.FullName;
        }
    }
}
