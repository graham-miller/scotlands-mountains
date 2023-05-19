using System;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Reflection;
using System.Text.Json;
using ScotlandsMountains.Domain;

namespace ScotlandsMountains.Data
{
    public class Dao
    {
        private readonly Lazy<Root> _root = new Lazy<Root>(() =>
        {
            using (var resourceStream = Assembly.GetAssembly(typeof(Dao)).GetManifestResourceStream($"{typeof(Dao).Namespace}.Resources.root.json.zip"))
            using (var zipArchive = new ZipArchive(resourceStream))
            using (var reader = new StreamReader(zipArchive.Entries[0].Open()))
            {
                var json = reader.ReadToEnd();
                var options = new JsonSerializerOptions {PropertyNamingPolicy = JsonNamingPolicy.CamelCase};
                return JsonSerializer.Deserialize<Root>(json, options);
            }
        });

        public IQueryable<Mountain> Mountains => _root.Value.Mountains.AsQueryable();
        
        public IQueryable<Classification> Classifications => _root.Value.Classifications.AsQueryable();
    }
}
