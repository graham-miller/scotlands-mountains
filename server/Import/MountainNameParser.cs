using System;
using System.Collections.Generic;
using System.Text;
using ScotlandsMountains.Domain;

namespace ScotlandsMountains.Import
{
    internal static class MountainNameParser
    {
        public static void Parse(Mountain mountain)
        {
            var raw = mountain.Name;
            var alias = string.Empty;
            var name = string.Empty;

            var inAlias = false;

            foreach (var @char in mountain.Name)
            {
                if (@char == '[')
                {
                    inAlias = true;
                    alias = string.Empty;
                }
                else if (@char == ']')
                {
                    inAlias = false;
                    mountain.Aliases.Add(alias.Trim());
                }
                else if (inAlias)
                {
                    alias += @char;
                }
                else
                {
                    name += @char;
                }
            }

            mountain.Name = name.Trim();
        }
    }
}
