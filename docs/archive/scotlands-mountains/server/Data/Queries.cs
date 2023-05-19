using System;
using System.Collections.Generic;
using System.Linq;
using ScotlandsMountains.Domain;

namespace ScotlandsMountains.Data
{
    public static class Queries
    {
        public static Mountain GetById(this IQueryable<Mountain> mountains, string id)
        {
            return mountains.SingleOrDefault(mountain => mountain.Id == id);
        }

        public static IEnumerable<Mountain> GetByClassification(this IQueryable<Mountain> mountains, Classification classification)
        {
            return mountains.Where(mountain => mountain.Classifications.Contains(classification));
        }

        public static IEnumerable<Mountain> Search(this IQueryable<Mountain> mountains, string term)
        {
            return mountains.Where(mountain => mountain.Name.Contains(term, StringComparison.InvariantCultureIgnoreCase));
        }

        public static Classification GetById(this IQueryable<Classification> classifications, string id)
        {
            return classifications.SingleOrDefault(classification => classification.Id == id);
        }
    }
}