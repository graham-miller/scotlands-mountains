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
            new Importer().Import();
        }
    }
}