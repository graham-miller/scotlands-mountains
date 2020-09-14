using System;
using System.Collections.Generic;
using System.Linq;
using ScotlandsMountains.Domain;

namespace ScotlandsMountains.Data
{
    public class MountainDao
    {
        private readonly Root _root;

        public MountainDao(Root root)
        {
            _root = root;
        }

        public Mountain GetById(string id)
        {
            return _root.Mountains.SingleOrDefault(mountain => mountain.Id == id);
        }

        public IEnumerable<Mountain> GetByClassification(Classification classification)
        {
            return _root.Mountains.Where(mountain => mountain.Classifications.Contains(classification));
        }

        public IEnumerable<Mountain> Search(string term)
        {
            return _root.Mountains.Where(mountain => mountain.Name.Contains(term, StringComparison.InvariantCultureIgnoreCase));
        }
    }
}