using System.IO;
using System.Linq;
using System.Reflection;
using System.Text.Json;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using ScotlandsMountains.Domain;
using JsonSerializer = System.Text.Json.JsonSerializer;

namespace Api
{
    public class ApiFunctions
    {
        private readonly Root _root;

        public ApiFunctions()
        {
            using (var resourceStream = Assembly.GetAssembly(GetType()).GetManifestResourceStream($"{GetType().Namespace}.Resources.root.json"))
            using (var reader = new StreamReader(resourceStream))
            {
                var json = reader.ReadToEnd();
                var options = new JsonSerializerOptions {PropertyNamingPolicy = JsonNamingPolicy.CamelCase};
                _root = JsonSerializer.Deserialize<Root>(json, options);
            }

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
    }
}
