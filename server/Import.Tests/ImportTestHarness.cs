using System;
using System.Text.Json;
using System.Text.Json.Serialization;
using NUnit.Framework;

namespace ScotlandsMountains.Import.Tests
{
    public class ImportTestHarness
    {
        [Test]
        public void Runner()
        {
            var importer = new Importer();
            importer.Import();
            var mountains = importer.Mountains;

            var options = new JsonSerializerOptions()
            {
                WriteIndented = true,
                PropertyNamingPolicy = JsonNamingPolicy.CamelCase
            };

            var json = JsonSerializer.Serialize(mountains, options);

        }
    }
}