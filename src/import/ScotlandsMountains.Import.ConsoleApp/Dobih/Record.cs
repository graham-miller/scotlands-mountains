using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics.Metrics;
using System.Diagnostics;
using System.Linq;
using System.Runtime.Intrinsics.X86;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;
using CsvHelper;
using CsvHelper.Configuration.Attributes;
using Spectre.Console;
using System.ComponentModel;

// ReSharper disable InconsistentNaming
// ReSharper disable StringLiteralTypo
// ReSharper disable IdentifierTypo
#pragma warning disable CS8618

namespace ScotlandsMountains.Import.ConsoleApp.Dobih
{
    public class Record
    {
        /// <summary>
        /// A unique hill identifier to assist with revision and help users raise queries with the authors. The hill number will not be changed during the lifetime of the database unless it is unavoidable; such rare events will be well publicised. To upgrade non-Access versions, sort the old and new releases by hill number and copy and paste your personal ascent records from one to the other. The total number of British hills generally increases between releases, so paste your British and Irish records separately.
        /// </summary>
        [Name("Number")]
        public int Number { get; set; }

        /// <summary>
        /// <para>The name(s) by which the hill generally appears in lists and maps. If this varies, we usually prefer the name most compatible with current OS mapping unless another name is particularly well known. Alternative names are given in square brackets. Qualifiers are enclosed in round brackets.</para>
        /// <para>For some multi-topped hills e.g.Liathach and Quinag, the SMC gives both names.For Munros and Corbetts, the Name field gives the two names separated by a hyphen.This allows users to search the database on either name.For Munro Tops we only give the summit name, as the range name will appear in the Parent (SMC) field. We have followed the same convention for a few non-SMC hills where the summit has a different name from the hill, usually when the original list gives both e.g.Birnam Hill - King's Seat.</para>
        /// <para>Scots Gaelic names have a space after a' when this is a contraction of "an". Thus we give Stuc a' Chroin rather than Stuc a'Chroin. The space is grammatically correct and is usually present on OS maps. Prior to version 16 we omitted the space to align with RHB, the TACit Tables and most hill names in Munro's Tables, but the SMC gives a space in their more recent publications and other authors are starting to do so.Searches on hill name in the Access version of the database and on Hill Bagging will work with or without a space.</para>
        /// <para>To facilitate searching, accents in Gaelic and Welsh names have been removed.</para>
        /// <para>Irish hill names are taken from MountainViews and Clements' TACit Tables. For British hills we try to include all names appearing in maps and lists that users are likely to search on, even if incorrect.</para>
        /// </summary>
        [Name("Name")]
        public string Name { get; set; }

        /// <summary>
        /// <para>The hill number and name of the Munro or Donald to which Munro Tops and Donald Tops are linked. For Munro Tops the hierarchy is shown in Munro's Tables. For a few tops the parent is topographically incorrect on current mapping (i.e. not the hill linked by the highest col), e.g. the SMC parent of 527 Carn Lochan is Cairn Gorm rather than Ben Macdui, the parent of 1015 Stob Cadha Gobhlach is Sgurr Fiona instead of Bidein a' Ghlas Thuill, and the parent of 811 Ciste Dhubh is Mam Sodhail not Carn Eighe.</para>
        /// <para>For Donald Tops the 1953, 1969 and 1974 editions of Munro's Tables show the hierarchy correctly but later editions do not. For example, hill 1652 Ben Ever is a top of Ben Cleuch but from 1981 onwards is shown underneath Blairdenon Hill, and hill 1897 Coomb Dod is shown above rather than below its parent Hillshaw Head. Parents of former Section 13—Appendix hills and the Glen Artney hills that entered the Tables in 1997 have been assigned by us.</para>
        /// </summary>
        [Name("Parent (SMC)")]
        public int? ParentSmc { get; set; }

        /// <summary>
        /// The name of the RHB/TACit Section.
        /// </summary>
        [Name("Parent name (SMC)")]
        public string? ParentNameSmc { get; set; }

        /// <summary>
        /// <para>The RHB/TACit Section number. Sections 1-17 correspond to those in Munro's Tables, enlarged to include lesser hills. In Corbett Tops and Corbetteers (1999) sections 5, 7 and 8 were split for the first time into West (A) and East (B) sections. Section 26 was subsequently split in the Graham Tops booklet. Note that 10A and 10B in Munro's Tables do not correspond to 10A and 10B in RHB.</para>
        /// <para>Sections 43-56 apply to Ireland.We have created Section 57 for the Channel Islands.</para>
        /// <para>Subsequent to the publication of RHB, the boundary between Sections 1 and 26 was moved to follow the course of the Highland Boundary Fault, resulting in some hills being moved from 1B to 26B.The boundary between Sections 10B and 10C was moved eastwards to Loch Blair and the Allt a' Choire Riabhaich. This resulted in Sgurr Mhurlagain being transferred from 10B in RHB to 10C in Corbett Tops and Corbetteers.</para>
        /// <para>Hills duplicated in more than one section of the RHB/TACit Tables, or which could be put in more than one section, have been treated as follows:</para>
        /// <para>Hills on the England-Scotland border: These hills belong to both Section 28B and Section 33 and are searchable in both sections in Hill Bagging and Access.In the Excel and csv versions they have been assigned to Section 33 with the exception of Cairn Hill West Top in 28B.This Donald Top does not appear in English lists (except as a deleted Nuttall, under the name Hangingstone Hill) as the drop before ascending to Cairn Hill is only 5m.</para>
        /// <para>Black Mountain(2242, Wales): Formerly listed in RHB/TACit as belonging to both England and Wales, but from May 2007 deemed to be in Wales only(32A) for the purposes of lists and databases.The summit is in Wales.</para>
        /// <para>Cuilcagh (20137, Ireland): Assigned to Section 45D by Clements but is on the International border and the 44A/45D boundary.Cuilcagh is deemed to be in 45D in the Republic of Ireland.</para>
        /// </summary>
        [Name("Section")]
        public string Section { get; set; }

        /// <summary>
        /// The name of the RHB/TACit Section.
        /// </summary>
        [Name("Region")]
        public string Region { get; set; }

        /// <summary>
        /// <para>This field is used principally for the following:</para>
        /// <list type="bullet">
        /// <item>Donald Sections in Munro's Tables</item>
        /// <item>Wainwright volumes</item>
        /// <item>Nuttall book chapters</item>
        /// <item>SIB Regions</item>
        /// <item>Irish hills</item>
        /// </list>
        /// <para>Nuttalls and Donalds area names are used for all hills belonging to those lists.This facilitates comparison with the original lists and will also serve for sorting Wainwrights by volume. For islands, the area name is taken from the maritime Region set out in The Significant Islands of Britain and Ireland (SIBs) by Alan Holmes. Within the Irish mainland, most hills are given the area names in use by MountainViews.Lower hills not belonging to the relevant hill list may not have had their Area assigned.</para>
        /// <para>A few hills on the Scotland–England border belong to "Cheviots" in the Nuttalls' volume and "Roxburgh and Cheviots" in the Donalds listing in Munro's Tables. This presents a problem with the Excel and csv versions of the database, unless one adopts the clumsy solution of giving each list a separate Area field. Furthermore, in version 12 we wished to assign area names to other Lowland hills and "Roxburgh and Cheviots" is far from ideal.All versions of Munro's Tables prior to 1997 give two areas, "Roxburgh" (section 11) and "Cheviots" (section 12). The SMC amalgamated the two regions when they removed Auchope Cairn and the six unnumbered English tops in 1997, leaving only three hills in total. We decided the simplest solution was to revert to the pre-1997 sections, as "Cheviots" is also the Nuttalls area name. Accordingly, 1906 Cauldcleuch Head is in "Roxburgh", and 1846 Cairn Hill West Top, 2303 Cairn Hill and 2305 Auchope Cairn are in "Cheviots". There is no conflict between Nuttalls and Wainwrights because the Nuttalls use the Wainwright volume titles.</para>
        /// <para>For Wainwright Outlying Fells we have extended the areas defined in the Pictorial Guides by continuing the Windermere boundary southwards along the River Leven to Greenodd, and from Bassenthwaite Lake north-west along the River Derwent.In England and Wales, Nuttall and Wainwright areas have been assigned to many other hills falling within their boundaries, with Central Wales subdivided into three regions, but this process is incomplete for the Tumps.</para>
        /// <para>In Wales, we needed to define the boundary between the Arans and Berwyns for the hills south of Bala from Rhiwaedog-uwch-afon (3421) in the north to Mynydd Maes-glas(3424) in the south.The easiest solution would be to put them all in the Arans or all in the Berwyns. However in the Nuttalls' book, Moel y Cerrig Duon (2116) belongs to the Arans and Foel y Geifr (2115) and Foel Goch (2123) to the Berwyns. Topographically this is not logical, but the Nuttalls clearly did so because Moel y Cerrig Duon is conveniently included in the same walk as the hills west of the road summit. Our solution is to assign those hills south of Moel y Cerrig Duon and south-west of Lake Vyrnwy to the Arans, and those north of Moel y Cerrig Duon and to the north-east of Lake Vyrnwy in the Berwyns, with the exception of Moel Eunant (3412) which is a satellite of Moel y Cerrig Duon. We feel this is the best we can do without breaking the alignment with the Nuttalls' book.</para>
        /// <para>To divide the Arenigs from the Moelwyns we chose to make the boundary Ffestiniog-B4391-B4407.There are other options but none are demonstrably better.The Moelwyns (as defined by the Nuttalls) span two RHB sections, 30B and 30D.</para>
        /// </summary>
        [Name("Area")]
        public string? Area { get; set; }

        /// <summary>
        /// <para>In Excel, the island name for British hills having two or more Tumps on an island landmass.For islands that are connected to higher ground via a landbridge, when the tide is between MHWS and MLWS, (t) is appended to the island name to indicate 'tidal'. Islands with fewer than two Tumps are in one of four categories: Mono Tump island; Mono Tump island(t); Non Tump island & Non Tump island(t).</para>
        /// <para>In the Access version, the island name is shown in the Area field.To search on this field in Hill Bagging, list the SIBs and then select Hills by Island from the menu on the left.</para>
        /// <para>The DoBIH does not currently offer an Irish island list.</para>
        /// </summary>
        [Name("Island")]
        public string? Island { get; set; }

        /// <summary>
        /// The geographical region according to the scheme published in Mark Jackson's Humps e-book. Z08–Z16 were subsequently added to accommodate Tump islands. In Access, the Topo Section is a searchable option in the Area/Region dropdown box; in the results screen it is given in the bottom row of the Areas/Regions table.
        /// </summary>
        [Name("Topo Section")]
        public string? TopoSection { get; set; }

        /// <summary>
        /// <para>This field is shown in the Excel/csv versions and on Hill Bagging.It gives the Current County or Unitary Authority for the hill. The Access version does not give the county in the search results but offers a search of all hills by county in the Areas/Regions dropdown box.</para>
        /// <para>Membership is calculated using the grid reference and pre-programmed polygons approximating the county boundaries.It may occasionally misassign a hill close to a boundary.Please let us know if you discover an error.</para>
        /// </summary>
        [Name("County")]
        public string? County { get; set; }

        [Name("Classification")]
        public string Classification { get; set; }

        [Name("Map 1:50k")]
        public string? Map1To50K { get; set; }

        [Name("Map 1:25k")]
        public string? Map1To25K { get; set; }

        [Name("Metres")]
        public decimal Metres { get; set; }

        [Name("Feet")]
        public int Feet { get; set; }

        /// <summary>
        /// A 6-figure summit grid reference intended for use with maps.
        /// </summary>
        [Name("Grid ref")]
        public string GridRef { get; set; }

        /// <summary>
        /// A 10-figure summit grid reference suitable for input to most hand-held GPS instruments, including all models in the Garmin range.
        /// </summary>
        [Name("Grid ref 10")]
        public string? GridRef10 { get; set; }

        /// <summary>
        /// Drop, also known as relative height in Britain and Ireland and prominence in the US, is defined as the height difference in metres between the summit and the col connecting the hill to a higher summit. Where there is more than one such col, the highest is chosen.
        /// Drops given to 0.1m are from surveys or LIDAR.
        /// </summary>
        [Name("Drop")]
        public decimal Drop { get; set; }

        /// <summary>
        /// Cols are usually much less well defined than summits. Some 6-figure col grid references are subject to considerable uncertainty; even when spot heights are available, they are not always located at the col. Within much of Ireland there is no data beyond contouring for col position and height. There is, therefore, much greater use of contour interpolation and consequently lower accuracy.
        /// Most col grid references given to 8 or 10 figures.
        /// </summary>
        [Name("Col grid ref")]
        public string ColGridRef { get; set; }

        /// <summary>
        /// Col heights given to 0.1m are from surveys or LIDAR.
        /// </summary>
        [Name("Col height")]
        public decimal ColHeight { get; set; }

        /// <summary>
        /// <para>The feature on or around the summit to which the 10 figure grid reference refers. The summit area may be adorned with several objects (trig pillar, cairn, wind-shelter, fence etc.) and the resolution of the GPS is usually sufficient to be able to distinguish the positions of these features. Note that a cairn or trig pillar is not always at the highest point of the hill, which may itself be featureless. Consequently, the Feature field may contain the entry 'no feature' even though a cairn, trig or other feature is in the vicinity. This is particularly likely for hills that have been surveyed. In such cases the Observations field may contain a ten figure grid reference for the cairn or trig.</para>
        /// <para>Where no survey equipment has been employed, we do not claim that the feature and its accompanying ten-figure grid reference represents the true summit of the hill; it is the best endeavour of the contributor who submits the data.</para>
        /// </summary>
        [Name("Feature")]
        public string? Feature { get; set; }

        /// <summary>
        /// This field contains information that supplements the Feature field. Most often it gives ten-figure grid references for other high points, either alternative summit locations or features that have been surveyed as lower.
        /// </summary>
        [Name("Observations")]
        public string? Observations { get; set; }

        /// <summary>
        /// This field records whether any of the summit position, height, drop, col height or col position were determined by surveying, and if so the instrument(s) used. Data given to one or more decimal places are usually from survey measurements. Thus for hill 2051 Mynydd y Cwm the Survey field contains "Leica NA730/Leica 530" showing that these instruments were used in the determination of col position, col height, summit position and summit height; the respective fields contain entries to 0.1m. We include "LIDAR" in the Survey field only if the data were used in conjunction with an instrumental survey, e.g. on 19212 Currock Hill and 18430 Warren Hill.
        /// </summary>
        [Name("Survey")]
        public string? Survey { get; set; }

        [Name("Climbed")]
        [BooleanFalseValues("")]
        public bool Climbed { get; set; }

        [Name("Country")]
        public string Country { get; set; }

        /// <summary>
        /// In Excel/csv, the relevant county or counties for a County Top.
        /// </summary>
        [Name("County Top")]
        public string? CountyTop { get; set; }

        /// <summary>
        /// The date of the last change to the primary data: classification, 6-figure GR, height, drop and col location.
        /// </summary>
        [Name("Revision")]
        public string Revision { get; set; }

        /// <summary>
        /// Significant revisions, alternative summit locations not from site visits (which would be reported in the Observations field), and other explanatory notes. We do not comment on revisions of a routine nature.
        /// </summary>
        [Name("Comments")]
        public string? Comments { get; set; }

        /// <summary>
        /// <para>Link to an OS 1:25000 map on www.streetmap.co.uk. Smaller scales are available. For hills lacking a 10-figure grid reference the arrow will point to the SW corner of the 100m square defined by the 6-figure GR.</para>
        /// <para>For Irish hills, link to the hill's page on MountainViews. For hills not offered by MountainViews no map will be shown. For Northern Ireland, the resources on the Links page of this website can be used to access 1:50k and 1:10k mapping.</para>
        /// </summary>
        [Name("Streetmap/MountainViews")]
        public string? StreetmapMountainViews { get; set; }

        /// <summary>
        /// <para>Link to Geograph offering OS mapping at 1:25000, 1:50000 and 1:250,000 scales and photographs within each 1km square. Previous feeds offered a larger scale with contours and additional spot heights but these disappeared some years ago.</para>
        /// <para>Detailed mapping is not available in the Channel Islands and Ireland, where Geograph uses Google Maps and OpenStreetMap, respectively.</para>
        /// </summary>
        [Name("Geograph")]
        public string Geograph { get; set; }

        /// <summary>
        /// Link to the hill's page in Hill Bagging. The page offers links to additional mapping resources including OS Maps, Magic Maps, NLS (for historic mapping) and OpenStreetMap. OS Maps used to offer 5m contours and Magic Maps additional spot heights at larger scales, but the current products are less useful. Scotlis and DataMapWales offer 5m contouring derived from a superior OS digital product. See Links for information on these resources,
        /// </summary>
        [Name("Hill-bagging")]
        public string HillBagging { get; set; }

        /// <summary>
        /// Absolute grid reference (eastings, northings) in metres relative to the Ordnance Survey National Grid origin, Irish Ordnance Survey National Grid origin, or UTM zone 30 origin as appropriate. Required by some GIS software e.g. ArcView and MapInfo. Not available on Hill Bagging except via the Geograph link, where it is shown on moving the cursor inside the zoomable map.
        /// </summary>
        [Name("Xcoord")]
        public int XCoord { get; set; }

        /// <summary>
        /// Absolute grid reference (eastings, northings) in metres relative to the Ordnance Survey National Grid origin, Irish Ordnance Survey National Grid origin, or UTM zone 30 origin as appropriate. Required by some GIS software e.g. ArcView and MapInfo. Not available on Hill Bagging except via the Geograph link, where it is shown on moving the cursor inside the zoomable map.
        /// </summary>
        [Name("Ycoord")]
        public int YCoord { get; set; }

        /// <summary>
        /// WGS84 coordinates calculated from the xcoord, ycoord values. The accuracy will depend on the source of the measurement. Use of latitude/longitude gives compatibility across Britain, Ireland and the Channel Islands. Not available in Hill Bagging except by showing the map and moving the cursor to the triangle marker.
        /// </summary>
        [Name("Latitude")]
        public decimal Latitude { get; set; }

        /// <summary>
        /// WGS84 coordinates calculated from the xcoord, ycoord values. The accuracy will depend on the source of the measurement. Use of latitude/longitude gives compatibility across Britain, Ireland and the Channel Islands. Not available in Hill Bagging except by showing the map and moving the cursor to the triangle marker.
        /// </summary>
        [Name("Longitude")]
        public decimal Longitude { get; set; }

        /// <summary>
        /// <para>True 10-figure grid reference, for use with maps. Exactly equivalent to xcoord, ycoord.</para>
        /// <para>For hills having an entry in the Grid Ref 10 field, the systematic component of the GPS error has been removed.For hills lacking a 10-figure GR, the 6-figure GR is converted to a 10-figure GR by padding with zeros. Used for generating the Geograph map links, which unlike Streetmap do not accept xcoord/ycoord or lat/long. Not shown in the search results table or in Hill Bagging, but available in the hills table of the Access database and in the Excel and csv versions.</para>
        /// </summary>
        [Name("GridrefXY")]
        public string GridRefXY { get; set; }

        /// <summary>
        /// A numeric version of Section given in the Excel and csv versions.
        /// </summary>
        [Name("_Section")]
        public decimal _Section { get; set; }

        /// <summary>
        /// <para>The hill number of the parent Marilyn of lower prominence hills. In the Excel and csv versions the hill's own number is given for hills that are parents (there are no parents of parents) and '0' indicates a non-Marilyn with no parent. Thus a filter or sort on this column will return a parent (usually first) and all its children. An equivalent facility is provided in Access within the "Parent (Ma)" query, accessible from the Queries menu.</para>
        /// <para>Tidal islands lacking a Marilyn will have a parent if the col height is greater than zero when measured to the appropriate datum(Ordnance Datum Newlyn in mainland Britain, Malin Head for the Republic of Ireland, and Belfast for Northern Ireland).</para>
        /// </summary>
        [Name("Parent (Ma)")]
        public int ParentMa { get; set; }

        /// <summary>
        /// <para>The nam of the parent Marilyn of lower prominence hills. In the Excel and csv versions the hill's own number is given for hills that are parents (there are no parents of parents) and '0' indicates a non-Marilyn with no parent. Thus a filter or sort on this column will return a parent (usually first) and all its children. An equivalent facility is provided in Access within the "Parent (Ma)" query, accessible from the Queries menu.</para>
        /// <para>Tidal islands lacking a Marilyn will have a parent if the col height is greater than zero when measured to the appropriate datum(Ordnance Datum Newlyn in mainland Britain, Malin Head for the Republic of Ireland, and Belfast for Northern Ireland).</para>
        /// </summary>
        [Name("Parent name (Ma)")]
        public string? ParentNameMa { get; set; }

        /// <summary>
        /// For Irish hills, the MountainViews hill number, as given in the hill page's URL on the MountainViews website which takes the form mountainviews.ie/summit/xxxx where xxxx is MVNumber. Shown in the Excel and csv versions, and in the MVNumbers query in Access.
        /// </summary>
        [Name("MVNumber")]
        public int? MVNumber { get; set; }

        [Name("Ma")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool Marilyn { get; set; }

        [Name("Ma=")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool MarilynTwin { get; set; }

        [Name("Hu")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool Hump { get; set; }

        [Name("Hu=")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool HumpTwin { get; set; }

        [Name("Tu")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool Tump { get; set; }

        [Name("Sim")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool Simm { get; set; }

        [Name("5")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool Dodd { get; set; }

        [Name("M")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool Munro { get; set; }

        [Name("MT")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool MunroTop { get; set; }

        [Name("F")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool Furth { get; set; }

        [Name("C")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool Corbett { get; set; }

        [Name("G")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool Graham { get; set; }

        [Name("D")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool Donald { get; set; }

        [Name("DT")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool DonaldTop { get; set; }

        [Name("Hew")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool Hewitt { get; set; }

        [Name("N")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool Nuttall { get; set; }

        [Name("Dew")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool Dewey { get; set; }

        [Name("DDew")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool DonaldDewey { get; set; }

        [Name("HF")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool HighlandFive { get; set; }

        [Name("4")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool Tump400To499M { get; set; }

        [Name("3")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool Tump300To399M { get; set; }

        [Name("2")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool Tump200To299M { get; set; }

        [Name("1")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool Tump100To199M { get; set; }

        [Name("0")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool Tump0To99M { get; set; }

        [Name("W")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool Wainwright { get; set; }

        [Name("WO")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool WainwrightOutlyingFell { get; set; }

        [Name("B")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool Birkett { get; set; }

        [Name("Sy")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool Synge { get; set; }

        [Name("Fel")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool Fellranger { get; set; }

        [Name("CoH")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool CountyTopHistoricPre1974 { get; set; }

        [Name("CoH=")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool CountyTopHistoricPre1974Twin { get; set; }

        [Name("CoU")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool CountyTopCurrentCountyorUnitaryAuthority { get; set; }

        [Name("CoU=")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool CountyTopCurrentCountyorUnitaryAuthorityTwin { get; set; }

        [Name("CoA")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool CountyTopAdministrative1974ToMid1990s { get; set; }

        [Name("CoA=")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool CountyTopAdministrative1974ToMid1990sTwin { get; set; }

        [Name("CoL")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool CountyTopCurrentLondonBorough { get; set; }

        [Name("CoL=")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool CountyTopCurrentLondonBoroughTwin { get; set; }

        [Name("SIB")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool SignificantIslandofBritain { get; set; }

        [Name("sMa")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool SubMarilyn { get; set; }

        [Name("sHu")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool SubHump { get; set; }

        [Name("sSim")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool SubSimm { get; set; }

        [Name("s5")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool SubDodd { get; set; }

        [Name("s4")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool SubTump400To499M { get; set; }

        [Name("Mur")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool Murdo { get; set; }

        [Name("CT")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool CorbettTop { get; set; }

        [Name("GT")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool GrahamTop { get; set; }

        [Name("BL")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool BuxtonAndLewis { get; set; }

        [Name("Bg")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool Bridge { get; set; }

        [Name("Y")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool Yeaman { get; set; }

        [Name("Cm")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool Clem { get; set; }

        [Name("T100")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool Trail100 { get; set; }

        [Name("xMT")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool DeletedMunroTop { get; set; }

        [Name("xC")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool DeletedCorbett { get; set; }

        [Name("xG")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool DeletedGraham { get; set; }

        [Name("xN")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool DeletedNuttall { get; set; }

        [Name("xDT")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool DeletedDonaldTop { get; set; }

        [Name("Dil")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool Dillon { get; set; }

        [Name("VL")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool VandeleurLynam { get; set; }

        [Name("A")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool Arderin { get; set; }

        [Name("Ca")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool Carn { get; set; }

        [Name("Bin")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool Binnion { get; set; }

        [Name("O")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool OtherList { get; set; }

        [Name("Un")]
        [BooleanTrueValues("1")]
        [BooleanFalseValues("0")]
        public bool Unclassified { get; set; }
    }
}
