using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.Extensions.Logging;
using ScotlandsMountains.Data;

namespace ScotlandsMountains.Api
{
    public class ApiFunctions
    {
        private readonly Dao _dao;

        public ApiFunctions()
        {
            _dao = new Dao();
        }

        // http://localhost:7071/api/classifications
        [FunctionName("GetClassifications")]
        public async Task<IActionResult> GetClassifications(
            [HttpTrigger(AuthorizationLevel.Anonymous, "GET", Route="classifications")] HttpRequest req,
            ILogger log)
        {
            var result = _dao.Classifications
                .Where(classification => classification.Enabled)
                .OrderBy(classification => classification.Order)
                .Select(classification => new
                {
                    classification.Id,
                    classification.Name,
                    classification.Description
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
            var classification = _dao.Classifications.GetById(id);

            if (classification == null) return new NotFoundResult();

            var mountains = _dao.Mountains
                .GetByClassification(classification)
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
                classification.Description,
                mountains.Count,
                Mountains = mountains
            });
        }

        // http://localhost:7071/api/search?term=nev
        [FunctionName("Search")]
        public async Task<IActionResult> Search(
            [HttpTrigger(AuthorizationLevel.Anonymous, "GET", Route="search")] HttpRequest req,
            ILogger log)
        {
            if (!req.Query.TryGetValue("term", out var terms)) return new BadRequestResult();

            if (terms.Count != 1) return new BadRequestResult();

            var term = terms.Single();

            var results = _dao.Mountains.Search(term)
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

        // http://localhost:7071/api/mountains/48pBw6Gew5
        [FunctionName("GetMountain")]
        public async Task<IActionResult> GetMountain(
            [HttpTrigger(AuthorizationLevel.Anonymous, "GET", Route="mountains/{id}")] HttpRequest req,
            string id,
            ILogger log)
        {
            var mountain = _dao.Mountains.GetById(id);

            if (mountain == null) return new NotFoundResult();

            return new OkObjectResult(mountain);
        }
    }
}
