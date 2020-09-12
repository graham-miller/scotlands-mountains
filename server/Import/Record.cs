using System;
using CsvHelper.Configuration.Attributes;

namespace ScotlandsMountains.Import
{
    public class Record
    {
        [Name("Number")]
        public string Number { get; set; }

        [Name("Name")]
        public string Name { get; set; }

        [Name("Parent (SMC)")]
        public int? ParentSMC { get; set; }

        [Name("Parent name (SMC)")]
        public string ParentNameSMC { get; set; }

        [Name("Section")]
        public string Section { get; set; }

        [Name("Region")]
        public string Region { get; set; }

        [Name("Area")]
        public string Area { get; set; }

        [Name("Island")]
        public string Island { get; set; }

        [Name("Topo Section")]
        public string TopoSection { get; set; }

        [Name("County")]
        public string County { get; set; }

        [Name("Classification")]
        public string Classification { get; set; }

        [Name("Map 1:50k")]
        public string Map1To50k { get; set; }

        [Name("Map 1:25k")]
        public string Map1To25k { get; set; }

        [Name("Metres")]
        public decimal Metres { get; set; }

        [Name("Feet")]
        public decimal Feet { get; set; }

        [Name("Grid ref")]
        public string GridRef { get; set; }

        [Name("Grid ref 10")]
        public string GridRef10 { get; set; }

        [Name("Drop")]
        public decimal Drop { get; set; }

        [Name("Col grid ref")]
        public string ColGridRef { get; set; }

        [Name("Col height")]
        public decimal ColHeight { get; set; }

        [Name("Feature")]
        public string Feature { get; set; }

        [Name("Observations")]
        public string Observations { get; set; }

        [Name("Survey")]
        public string Survey { get; set; }

        [Name("Climbed")]
        public string Climbed { get; set; }

        [Name("Country")]
        public string Country { get; set; }

        [Name("County Top")]
        public string CountyTop { get; set; }

        [Name("Revision")]
        public DateTime Revision { get; set; }

        [Name("Comments")]
        public string Comments { get; set; }

        [Name("Streetmap/MountainViews")]
        public string StreetmapMountainViews { get; set; }

        [Name("Geograph")]
        public string Geograph { get; set; }

        [Name("Hill-bagging")]
        public string HillBagging { get; set; }

        [Name("Xcoord")]
        public int Xcoord { get; set; }

        [Name("Ycoord")]
        public int Ycoord { get; set; }

        [Name("Latitude")]
        public decimal Latitude { get; set; }

        [Name("Longitude")]
        public decimal Longitude { get; set; }

        [Name("GridrefXY")]
        public string GridrefXY { get; set; }

        [Name("_Section")]
        public decimal SectionNumber { get; set; }

        [Name("Parent (Ma)")]
        public int ParentMa { get; set; }

        [Name("Parent name (Ma)")]
        public string ParentNameMa { get; set; }

        [Name("MVNumber")]
        public int? MVNumber { get; set; }

        [Name("Ma")]
        [ClassificationName("Marilyn")]
        public bool IsMarilyn { get; set; }

        [Name("Ma=")]
        [ClassificationName("Marilyn twin")]
        public bool IsMarilynTwin { get; set; }

        [Name("Hu")]
        [ClassificationName("HuMP")]
        public bool IsHuMP { get; set; }

        [Name("Hu=")]
        [ClassificationName("HuMP twin")]
        public bool IsHuMPTwin { get; set; }

        [Name("Tu")]
        [ClassificationName("Tump")]
        public bool IsTump { get; set; }

        [Name("Tu=")]
        [ClassificationName("Tump twin")]
        public bool IsTumpTwin { get; set; }

        [Name("Sim")]
        [ClassificationName("Simm")]
        public bool IsSimm { get; set; }

        [Name("5")]
        [ClassificationName("Dodd")]
        public bool IsDodd { get; set; }

        [Name("M")]
        [ClassificationName("Munro")]
        public bool IsMunro { get; set; }

        [Name("MT")]
        [ClassificationName("Munro Top")]
        public bool IsMunroTop { get; set; }

        [Name("F")]
        [ClassificationName("Furth")]
        public bool IsFurth { get; set; }

        [Name("C")]
        [ClassificationName("Corbett")]
        public bool IsCorbett { get; set; }

        [Name("G")]
        [ClassificationName("Graham")]
        public bool IsGraham { get; set; }

        [Name("D")]
        [ClassificationName("Donald")]
        public bool IsDonald { get; set; }

        [Name("DT")]
        [ClassificationName("Donald Top")]
        public bool IsDonaldTop { get; set; }

        [Name("Hew")]
        [ClassificationName("Hewitt")]
        public bool IsHewitt { get; set; }

        [Name("N")]
        [ClassificationName("Nuttall")]
        public bool IsNuttall { get; set; }

        [Name("Dew")]
        [ClassificationName("Dewey")]
        public bool IsDewey { get; set; }

        [Name("DDew")]
        [ClassificationName("Donald Dewey")]
        public bool IsDonaldDewey { get; set; }

        [Name("HF")]
        [ClassificationName("Highland Five")]
        public bool IsHighlandFive { get; set; }

        [Name("4")]
        [ClassificationName("400m to 499m TuMP")]
        public bool Is400mTo499mTuMP { get; set; }

        [Name("3")]
        [ClassificationName("300m to 399m TuMP")]
        public bool Is300mTo399mTuMP { get; set; }

        [Name("2")]
        [ClassificationName("200m to 299m TuMP")]
        public bool Is200mTo299mTuMP { get; set; }

        [Name("1")]
        [ClassificationName("100m to 199m TuMP")]
        public bool Is100mTo199mTuMP { get; set; }

        [Name("1=")]
        [ClassificationName("100m to 199m TuMP twin")]
        public bool Is100mTo199mTuMPTwin { get; set; }

        [Name("0")]
        [ClassificationName("0m to 99m TuMP")]
        public bool Is0mTo99mTuMP { get; set; }

        [Name("W")]
        [ClassificationName("Wainwright")]
        public bool IsWainwright { get; set; }

        [Name("WO")]
        [ClassificationName("Wainwright outlying fell")]
        public bool IsWainwrightOutlyingFell { get; set; }

        [Name("B")]
        [ClassificationName("Birkett")]
        public bool IsBirkett { get; set; }

        [Name("Sy")]
        [ClassificationName("Synge")]
        public bool IsSynge { get; set; }

        [Name("Fel")]
        [ClassificationName("Fellranger")]
        public bool IsFellranger { get; set; }

        [Name("CoH")]
        [ClassificationName("County Top – historic (pre-1974)")]
        public bool IsCountyTopHistoricPre1974 { get; set; }

        [Name("CoH=")]
        [ClassificationName("County Top – historic (pre-1974) twin")]
        public bool IsCountyTopHistoricPre1974Twin { get; set; }

        [Name("CoU")]
        [ClassificationName("County Top – current county or unitary authority")]
        public bool IsCountyTopCurrentCountyOrUnitaryAuthority { get; set; }

        [Name("CoU=")]
        [ClassificationName("County Top – current county or unitary authority twin")]
        public bool IsCountyTopCurrentCountyOrUnitaryAuthorityTwin { get; set; }

        [Name("CoA")]
        [ClassificationName("County Top – administrative (1974 to mid-1990s)")]
        public bool IsCountyTopAdministrative1974ToMid1990s { get; set; }

        [Name("CoA=")]
        [ClassificationName("County Top – administrative (1974 to mid-1990s) twin")]
        public bool IsCountyTopAdministrative1974ToMid1990sTwin { get; set; }

        [Name("CoL")]
        [ClassificationName("County Top – current London borough")]
        public bool IsCountyTopCurrentLondonBorough { get; set; }

        [Name("CoL=")]
        [ClassificationName("County Top – current London borough twin")]
        public bool IsCountyTopCurrentLondonBoroughTwin { get; set; }

        [Name("SIB")]
        [ClassificationName("Significant island of Britain")]
        public bool IsSignificantIslandOfBritain { get; set; }

        [Name("sMa")]
        [ClassificationName("Sub Marilyn")]
        public bool IsSubMarilyn { get; set; }

        [Name("sHu")]
        [ClassificationName("Sub HuMP")]
        public bool IsSubHuMP { get; set; }

        [Name("sSim")]
        [ClassificationName("Sub Simm")]
        public bool IsSubSimm { get; set; }

        [Name("s5")]
        [ClassificationName("Sub Dodd")]
        public bool IsSubDodd { get; set; }

        [Name("s4")]
        [ClassificationName("Sub 400m to 499m TuMP")]
        public bool IsSub400mTo499mTuMP { get; set; }

        [Name("Mur")]
        [ClassificationName("Murdo")]
        public bool IsMurdo { get; set; }

        [Name("CT")]
        [ClassificationName("Corbett Top")]
        public bool IsCorbettTop { get; set; }

        [Name("GT")]
        [ClassificationName("Graham Top")]
        public bool IsGrahamTop { get; set; }

        [Name("BL")]
        [ClassificationName("Buxton & Lewis")]
        public bool IsBuxtonLewis { get; set; }

        [Name("Bg")]
        [ClassificationName("Bridge")]
        public bool IsBridge { get; set; }

        [Name("Y")]
        [ClassificationName("Yeaman")]
        public bool IsYeaman { get; set; }

        [Name("Cm")]
        [ClassificationName("Clem")]
        public bool IsClem { get; set; }

        [Name("T100")]
        [ClassificationName("Trail 100")]
        public bool IsTrail100 { get; set; }

        [Name("xMT")]
        [ClassificationName("Deleted Munro Top")]
        public bool IsDeletedMunroTop { get; set; }

        [Name("xC")]
        [ClassificationName("Deleted Corbett")]
        public bool IsDeletedCorbett { get; set; }

        [Name("xG")]
        [ClassificationName("Deleted Graham")]
        public bool IsDeletedGraham { get; set; }

        [Name("xN")]
        [ClassificationName("Deleted Nuttall")]
        public bool IsDeletedNuttall { get; set; }

        [Name("xDT")]
        [ClassificationName("Deleted Donald Top")]
        public bool IsDeletedDonaldTop { get; set; }

        [Name("Dil")]
        [ClassificationName("Dillon")]
        public bool IsDillon { get; set; }

        [Name("VL")]
        [ClassificationName("Vandeleur-Lynam")]
        public bool IsVandeleurLynam { get; set; }

        [Name("A")]
        [ClassificationName("Arderin")]
        public bool IsArderin { get; set; }

        [Name("MDew")]
        [ClassificationName("Myrddyn Dewey")]
        public bool IsMyrddynDewey { get; set; }

        [Name("sMDew")]
        [ClassificationName("Sub Myrddyn Dewey")]
        public bool IsSubMyrddynDewey { get; set; }

        [Name("Ca")]
        [ClassificationName("Carn")]
        public bool IsCarn { get; set; }

        [Name("Bin")]
        [ClassificationName("Binnion")]
        public bool IsBinnion { get; set; }

        [Name("O")]
        [ClassificationName("Other list")]
        public bool IsOtherList { get; set; }

        [Name("Un")]
        [ClassificationName("Unclassified")]
        public bool IsUnclassified { get; set; }
    }

    public class ClassificationNameAttribute : Attribute
    {
        public ClassificationNameAttribute(string name)
        {
            Name = name;
        }

        public string Name { get; }
    }
}