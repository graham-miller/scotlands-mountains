using System.Collections.Generic;
using System.Linq;
using ScotlandsMountains.Domain;

namespace ScotlandsMountains.Data
{
    public class ClassificationDao
    {
        private readonly Root _root;

        public ClassificationDao(Root root)
        {
            _root = root;
        }

        public IEnumerable<Classification> GetAll()
        {
            return _root.Classifications;
        }

        public Classification GetById(string id)
        {
            return _root.Classifications.SingleOrDefault(classification => classification.Id == id);
        }
    }
}