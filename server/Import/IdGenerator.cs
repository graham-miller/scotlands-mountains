using System.Collections.Generic;
using HashidsNet;
using ScotlandsMountains.Domain;

namespace ScotlandsMountains.Import
{
    internal static class IdGenerator
    {
        public static void ApplyIdsTo<T>(IEnumerable<T> entities) where T : Entity
        {
            var salt = typeof(T).GetType().FullName;
            const int minHashLength = 10;
            const string alphabet = "abcdefghjkmnpqrstuvwxyzABCDEFGHJKMNPQRSTUVWXYZ23456789";
            const string seps = "cfhistuCFHISTU";
            var hashids = new Hashids(salt, minHashLength, alphabet, seps);
            var count = 0;

            foreach (var entity in entities)
            {
                count++;
                entity.Id = hashids.Encode(count);
            }
        }
    }
}
