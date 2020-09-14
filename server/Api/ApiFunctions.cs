using System;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Reflection;
using System.Text.Json;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Primitives;
using ScotlandsMountains.Domain;
using JsonSerializer = System.Text.Json.JsonSerializer;

namespace Api
{
    public class ApiFunctions
    {
        private readonly Root _root;

        public ApiFunctions()
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

        // http://localhost:7071/api/search?term=nev
        [FunctionName("Search")]
        public async Task<IActionResult> Search(
            [HttpTrigger(AuthorizationLevel.Anonymous, "GET", Route="search")] HttpRequest req,
            ILogger log)
        {
            StringValues terms;
            if (req.Query.TryGetValue("term", out terms))
            {
                if (terms.Count == 1)
                {
                    var term = terms.Single();

                    var results = _root.Mountains
                        .Where(mountain => mountain.Name.Contains(term, StringComparison.InvariantCultureIgnoreCase))
                        .OrderByDescending(mountain => mountain.Height)
                        .Select(mountain => new
                        {
                            mountain.Id,
                            mountain.Name,
                            mountain.Height,
                            mountain.Latitude,
                            mountain.Longitude
                        })
                        .ToList();

                    return new OkObjectResult(new
                    {
                        Term = term,
                        results.Count,
                        Results = results
                    });
                }
            }

            return new BadRequestResult();
        }

        // http://localhost:7071/api/mountains/48pBw6Gew5
        [FunctionName("GetMountain")]
        public async Task<IActionResult> GetMountain(
            [HttpTrigger(AuthorizationLevel.Anonymous, "GET", Route="mountains/{id}")] HttpRequest req,
            string id,
            ILogger log)
        {
            var mountain = _root.Mountains.SingleOrDefault(x => x.Id == id);

            if (mountain == null) return new NotFoundResult();

            return new OkObjectResult(mountain);
        }

        // http://localhost:7071/api/classifications
        [FunctionName("GetClassifications")]
        public async Task<IActionResult> GetClassifications(
            [HttpTrigger(AuthorizationLevel.Anonymous, "GET", Route="classifications")] HttpRequest req,
            ILogger log)
        {
            var result = _root.Classifications.Select(classification => new
            {
                classification.Id,
                classification.Name
            });

            return new OkObjectResult(result);
        }

        // http://localhost:7071/api/classifications/ZrxBrmG4EM
        [FunctionName("GetClassification")]
        public async Task<IActionResult> GetClassification(
            [HttpTrigger(AuthorizationLevel.Anonymous, "GET", Route="classifications/{id}")] HttpRequest req,
            string id,
            ILogger log)
        {
            var classification = _root.Classifications.SingleOrDefault(x => x.Id == id);

            if (classification == null) return new NotFoundResult();

            var mountains = _root.Mountains
                .Where(mountain => mountain.Classifications.Contains(classification))
                .OrderByDescending(mountain => mountain.Height)
                .Select(mountain => new
                {
                    mountain.Id,
                    mountain.Name,
                    mountain.Height,
                    mountain.Latitude,
                    mountain.Longitude
                })
                .ToList();

            return new OkObjectResult(new
            {
                classification.Name,
                classification.Id,
                mountains.Count,
                Mountains = mountains
            });
        }
    }
}
