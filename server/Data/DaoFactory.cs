using System.IO;
using System.IO.Compression;
using System.Reflection;
using System.Text.Json;
using ScotlandsMountains.Domain;

namespace ScotlandsMountains.Data
{
    public class DaoFactory
    {
        private readonly Root _root;

        public DaoFactory()
        {
            using (var resourceStream = Assembly.GetAssembly(GetType()).GetManifestResourceStream($"{GetType().Namespace}.Resources.root.json.zip"))
            using (var zipArchive = new ZipArchive(resourceStream))
            using (var reader = new StreamReader(zipArchive.Entries[0].Open()))
            {
                var json = reader.ReadToEnd();
                var options = new JsonSerializerOptions {PropertyNamingPolicy = JsonNamingPolicy.CamelCase};
                _root = JsonSerializer.Deserialize<Root>(json, options);
            }
        }

        public MountainDao GetMountainDao()
        {
            return new MountainDao(_root);
        }

        public ClassificationDao GetClassificationDao()
        {
            return new ClassificationDao(_root);
        }
    }
}
