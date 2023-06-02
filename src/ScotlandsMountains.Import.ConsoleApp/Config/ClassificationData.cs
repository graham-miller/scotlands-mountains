// ReSharper disable StringLiteralTypo
namespace ScotlandsMountains.Import.ConsoleApp.Config;

internal class ClassificationData : IEnumerable<ClassificationInfo>
{
    private static readonly IEnumerable<ClassificationInfo> Items = new List<ClassificationInfo>
    {
        new ("Marilyns", "Marilyn", x => x.Marilyn, "British and Irish hills of any height with a drop of at least 150 metres on all sides. The geographical area includes the Isle of Man and the islands of St Kilda."),
        new ("Marilyn twins", "Marilyn twin", x => x.MarilynTwin, "A Marilyn Twin Top is a summit of equal height to another Marilyn where the drop between the two is less than 150m and at least 30m. The only example is 21168 Knockalla Mountain NE Top in Ireland."),
        new ("HuMPs", "HuMP", x => x.Hump, "British and Irish Hills of any height with a drop of at least 100 metres or more on all sides. The name Hump stands for Hundred Metre Prominence."),
        new ("HuMP twins", "HuMP twin", x => x.HumpTwin, "A Twin Hump is defined as a summit of equal height to another Hump where the drop between the two summits is at least 30m but less than 100m."),
        new ("TuMPs", "TuMP", x => x.Tump, "British hills of any height with at least 30m of drop. The geographical area was extended to the Channel Islands in September 2014."),
        new ("Simms", "Simm", x => x.Simm, "British hills at least 600 metres high with a drop of at least 30 metres on all sides."),
        new ("Dodds", "Dodd", x => x.Dodd, "Hills in Scotland, England, Wales, the Isle of Man and Ireland between 500m and 599.9m high with a drop of at least 30 metres on all sides."),
        new ("Munros", "Munro", x => x.Munro, "Scottish hills at least 3000 feet in height regarded by the SMC as distinct and separate mountains, based on a list originally published in 1891."),
        new ("Munro Tops", "Munro Top", x => x.MunroTop, "Subsidiary summits meeting the height criterion of Munros are designated Munro Tops."),
        new ("Furths", "Furth", x => x.Furth, "Summits equivalent to the Munros and Tops in England, Wales and Ireland on the SMC's list are known as Furths."),
        new ("Corbetts", "Corbett", x => x.Corbett, "Scottish hills between 2500 and 2999 feet high with a drop of at least 500 feet (152.4m) on all sides."),
        new ("Grahams", "Graham", x => x.Graham, "Scottish hills at least 600m high and below 762m (2500 feet) with a drop of at least 150 metres on all sides."),
        new ("Donalds", "Donald", x => x.Donald, "Hills in the Scottish Lowlands at least 2000 feet high. 'Tops' are all elevations with a drop of at least 100 feet (30.48m) on all sides and elevations of sufficient topographical merit with a drop of between 50 and 100 feet."),
        new ("Donald Tops", "Donald Top", x => x.DonaldTop, ""),
        new ("Hewitts", "Hewitt", x => x.Hewitt, "Hills in England, Wales and Ireland at least 2000 feet high with a drop of at least 30 metres on all sides."),
        new ("Nuttalls", "Nuttall", x => x.Nuttall, "Hills in England and Wales at least 2000 feet high with a drop of at least 15 metres on all sides."),
        new ("Deweys", "Dewey", x => x.Dewey, "Hills in England, Wales and the Isle of Man at least 500m high and below 609.6m with a drop of at least 30m on all sides."),
        new ("Donald Deweys", "Donald Dewey", x => x.DonaldDewey, "Hills in the Scottish Lowlands at least 500m high and below 609.6m with a drop of at least 30m on all sides."),
        new ("Highland Fives", "Highland Five", x => x.HighlandFive, "Hills in the Scottish Highlands at least 500m high and below 600m with a drop of at least 30m on all sides."),
        new ("TuMPs (400m to 499m)", "TuMP (400m to 499m)", x => x.Tump400To499M, "British hills of any height with at least 30m of drop. The geographical area was extended to the Channel Islands in September 2014."),
        new ("TuMPs (300m to 399m)", "TuMP (300m to 399m)", x => x.Tump300To399M, "British hills of any height with at least 30m of drop. The geographical area was extended to the Channel Islands in September 2014."),
        new ("TuMPs (200m to 299m)", "TuMP (200m to 299m)", x => x.Tump200To299M, "British hills of any height with at least 30m of drop. The geographical area was extended to the Channel Islands in September 2014."),
        new ("TuMPs (100m to 199m)", "TuMP (100m to 199m)", x => x.Tump100To199M, "British hills of any height with at least 30m of drop. The geographical area was extended to the Channel Islands in September 2014."),
        new ("TuMPs (0m to 99m)", "TuMP (0m to 99m)", x => x.Tump0To99M, "British hills of any height with at least 30m of drop. The geographical area was extended to the Channel Islands in September 2014."),
        new ("Wainwrights", "Wainwright", x => x.Wainwright, "The 214 hills listed in volumes 1-7 of Wainwright's A Pictorial Guide to the Lakeland Fells."),
        new ("Wainwright Outlying Fells", "Wainwright Outlying Fell", x => x.WainwrightOutlyingFell, "Hills listed in Wainwright's The Outlying Fells of Lakeland."),
        new ("Birketts", "Birkett", x => x.Birkett, "Lake District hills over 1,000ft."),
        new ("Synges", "Synge", x => x.Synge, "Lake District hills over 1,000ft."),
        new ("Fellrangers", "Fellranger", x => x.Fellranger, ""),
        new ("County Tops (Historic Pre-1974)", "County Top (Historic Pre-1974)", x => x.CountyTopHistoricPre1974, "The highest point within (or sometimes on) the boundary of each county."),
        new ("County Tops twins (Historic Pre-1974)", "County Top (Historic Pre-1974 twin)", x => x.CountyTopHistoricPre1974Twin, "The highest point within (or sometimes on) the boundary of each county."),
        new ("County Tops (Current County or Unitary Authority)", "County Top (Current County or Unitary Authority)", x => x.CountyTopCurrentCountyorUnitaryAuthority, "The highest point within (or sometimes on) the boundary of each county."),
        new ("County Top twims (Current County or Unitary Authority)", "County Top (Current County or Unitary Authority twin)", x => x.CountyTopCurrentCountyorUnitaryAuthorityTwin, "The highest point within (or sometimes on) the boundary of each county."),
        new ("County Tops (Administrative 1974 to Mid-1990s)", "County Top (Administrative 1974 to Mid-1990s)", x => x.CountyTopAdministrative1974ToMid1990s, "The highest point within (or sometimes on) the boundary of each county."),
        new ("County Top twins (Administrative 1974 to Mid-1990s)", "County Top (Administrative 1974 to Mid-1990s twin)", x => x.CountyTopAdministrative1974ToMid1990sTwin, "The highest point within (or sometimes on) the boundary of each county."),
        new ("County Tops (Current London Borough)", "County Top (Current London Borough)", x => x.CountyTopCurrentLondonBorough, "The highest point within (or sometimes on) the boundary of each county."),
        new ("County Top twins (Current London Borough)", "County Top (Current London Borough twin)", x => x.CountyTopCurrentLondonBoroughTwin, "The highest point within (or sometimes on) the boundary of each county."),
        new ("Significant Islands of Britain", "Significant Island of Britain", x => x.SignificantIslandofBritain, "The Significant Islands of Britain and Ireland are defined to be completely surrounded by water, with either an area of at least 30 hectares within the MHWS contour line or an easily accessed summit prominence of at least 30 metres above MSL, all man-made links and structures being discounted. Sea stacks and other steep sided islands are therefore discounted."),
        new ("Sub-Marilyns", "Sub-Marilyn", x => x.SubMarilyn, "Hills that fall short of Marilyn status on drop by 10m or less."),
        new ("Sub-HuMPs", "Sub-HuMP", x => x.SubHump, "Hills that fall short of HuMP status on drop by 10m or less."),
        new ("Sub-Simms", "Sub-Simm", x => x.SubSimm, "Hills that fall short of Simm status on drop by 10m or less."),
        new ("Sub-Dodds", "Sub-Dodd", x => x.SubDodd, "Hills that fall short of Dodd status on drop by 10m or less."),
        new ("Sub-TuMPs (400m to 499m)", "Sub-TuMP (400m to 499m)", x => x.SubTump400To499M, "Hills that fall short of TuMP status on drop by 10m or less."),
        new ("Murdos", "Murdo", x => x.Murdo, "Scottish hills at least 3000 feet in height with a drop of at least 30 metres on all sides. All Murdos are Munros or Munro Tops but some Munro Tops fail to qualify as Murdos."),
        new ("Corbett tops", "Corbett top", x => x.CorbettTop, "Subsidiary summits meeting the height criterion of Corbetts are designated Corbetts Tops."),
        new ("Graham tops", "Graham top", x => x.GrahamTop, "Scottish hills at least 600m high and below 762m (2500 feet) with a drop of at least 30 metres on all sides."),
        new ("Buxton & Lewis", "Buxton & Lewis", x => x.BuxtonAndLewis, ""),
        new ("Bridges", "Bridge", x => x.Bridge, ""),
        new ("Yeamans", "Yeaman", x => x.Yeaman, "Scottish hills with a drop of 100m, or, failing that, at least 5km (walking distance) from any higher point."),
        new ("Clems", "Clem", x => x.Clem, "Hills in England, Wales and the Isle of Man with a drop of 100m, or, failing that, at least 5km (walking distance) from any higher point."),
        new ("Trail 100s", "Trail 100", x => x.Trail100, ""),
        new ("Deleted Munro tops", "Deleted Munro top", x => x.DeletedMunroTop, ""),
        new ("Deleted Corbetts", "Deleted Corbett", x => x.DeletedCorbett, ""),
        new ("Deleted Grahams", "Deleted Graham", x => x.DeletedGraham, ""),
        new ("Deleted Nuttalls", "Deleted Nuttall", x => x.DeletedNuttall, ""),
        new ("Deleted Donald tops", "Deleted Donald top", x => x.DeletedDonaldTop, ""),
        new ("Dillons", "Dillon", x => x.Dillon, "Hills in Ireland at least 2000 feet high."),
        new ("Vandeleur-Lynams", "Vandeleur-Lynam", x => x.VandeleurLynam, "Hills in Ireland at least 600 metres high with a drop of at least 15 metres on all sides."),
        new ("Arderins", "Arderin", x => x.Arderin, "Hills in Ireland at least 500 metres high with a drop of at least 30m on all sides."),
        new ("Carns", "Carn", x => x.Carn, "Hills in Ireland between 400 and 499.9m high with a drop of at least 30m on all sides."),
        new ("Binnions", "Binnion", x => x.Binnion, "Hills in Ireland with height below 400m and a drop of at least 100m on all sides."),
        new ("Other lists", "Other list", x => x.OtherList, ""),
        new ("Unclassified", "Unclassified", x => x.Unclassified, "")
    };

    public IEnumerator<ClassificationInfo> GetEnumerator()
    {
        return Items.GetEnumerator();
    }

    IEnumerator IEnumerable.GetEnumerator()
    {
        return ((IEnumerable)Items).GetEnumerator();
    }
}