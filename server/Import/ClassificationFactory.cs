using ScotlandsMountains.Domain;

namespace ScotlandsMountains.Import
{
    internal class ClassificationFactory
    {
        public Classification Build(string key)
        {
            switch (key)
            {
                case "M":
                    return new Classification("M", "Munro", true, 1, "Mountains in Scotland over 3,000ft (914.4m).");
                case "C":
                    return new Classification("C", "Corbett", true, 2, "Mountains in Scotland between 2,500ft and 3,000ft (762m and 914.4m) in height with a prominence of at least 500ft (152.4m).");
                case "G":
                    return new Classification("G", "Graham", true, 3, "Mountains in Scotland between 2,000ft and 2,499ft (610m and 762m) in height with a prominence of at least 150m (490ft).");
                case "Ma":
                    return new Classification("Ma", "Marilyn", true, 4, "Mountains of the British Isles with a prominence of at least 150m (490ft).");
                case "MT":
                    return new Classification("MT", "Munro Top", true, 5, "Lesser mountains in Scotland over 3,000ft (914.4m).");
                case "D":
                    return new Classification("D", "Donald", true, 6, "Mountains in the Scottish Lowlands over 2,000ft (610m).");
                case "DT":
                    return new Classification("DT", "Donald Top", true, 7, "Lesser mountains in the Scottish Lowlands over 2,000ft (610m).");
                case "DDew":
                    return new Classification("DDew", "Donald Dewey", true, 8, "Mountains in the Scottish lowlands between 500m and 2,000ft (609.6m) in height with a prominence of at least 30m (98ft).");
                case "Sim":
                    return new Classification("Sim", "Simm", true, 9, "Mountains of the British Isles over 600m (1,969ft) in height with a prominence of at least 30m (98ft).");
                case "5":
                    return new Classification("5", "Dodd", true, 10, "Mountains of the British Isles between 500m and 600m in height with a prominence of at least 30m (98ft).");
                case "HF":
                    return new Classification("HF", "Highland Five", true, 11, "Mountains in the Scottish highlands between 500m and 2,000ft (609.6m) in height with a prominence of at least 30m (98ft).");
                case "CoU":
                    return new Classification("CoU", "County Top", true, 12, "Highest mountains in a current county or unitary authority area.");
                case "Hu":
                    return new Classification("Hu", "HuMP", true, 13, "Mountains of the British Isles with a prominence of at least 100m (328ft).");
                case "4":
                    return new Classification("4", "400m to 499m TuMP", true, 14, "Mountains of the British Isles between 400m and 499m with a prominence of at least 30m (98ft).");
                case "3":
                    return new Classification("3", "300m to 399m TuMP", true, 15, "Mountains of the British Isles between 300m and 399m with a prominence of at least 30m (98ft).");
                case "2":
                    return new Classification("2", "200m to 299m TuMP", true, 16, "Mountains of the British Isles between 200m and 299m with a prominence of at least 30m (98ft).");
                case "1":
                    return new Classification("1", "100m to 199m TuMP", true, 17, "Mountains of the British Isles between 100m and 199m with a prominence of at least 30m (98ft).");
                case "0":
                    return new Classification("0", "0m to 99m TuMP", true, 18, "Mountains of the British Isles between 0m and 99m with a prominence of at least 30m (98ft).");
                case "s4":
                    return new Classification("s4", "Sub 400m to 499m TuMP", false, 99, "");
                case "xG":
                    return new Classification("xG", "Deleted Graham", false, 99, "");
                case "CoA":
                    return new Classification("CoA", "County Top – administrative (1974 to mid-1990s)", false, 99, "");
                case "sSim":
                    return new Classification("sSim", "Sub Simm", false, 99, "");
                case "xMT":
                    return new Classification("xMT", "Deleted Munro Top", false, 99, "");
                case "CoH":
                    return new Classification("CoH", "County Top – historic (pre-1974)", false, 99, "");
                case "sMa":
                    return new Classification("sMa", "Sub Marilyn", false, 99, "");
                case "Un":
                    return new Classification("Un", "Unclassified", false, 99, "");
                case "sHu":
                    return new Classification("sHu", "Sub HuMP", false, 99, "");
                case "SIB":
                    return new Classification("SIB", "Significant island of Britain", false, 99, "");
                case "xC":
                    return new Classification("xC", "Deleted Corbett", false, 99, "");
                case "O":
                    return new Classification("O", "Other list", false, 99, "");
                case "xDT":
                    return new Classification("xDT", "Deleted Donald Top", false, 99, "");
                case "xN":
                    return new Classification("xN", "Deleted Nuttall", false, 99, "");
                case "Hew":
                    return new Classification("Hew", "Hewitt", false, 99, "");
                case "N":
                    return new Classification("N", "Nuttall", false, 99, "");
                case "Dew":
                    return new Classification("Dew", "Dewey", false, 99, "");
                case "Hu=":
                    return new Classification("Hu=", "HuMP twin", false, 99, "");
                case "s5":
                    return new Classification("s5", "Sub Dodd", false, 99, "");
                default:
                    return null;
            }
        }
    }
}