import 'classification.dart';
import 'country.dart';
import 'mountain.dart';
import 'os_map.dart';
import 'region.dart';

class MountainGraph extends Mountain {
  final List<String> aliases;
  final List<OsMap> maps;
  final List<Classification> classifications;
  final List<Country> countries;
  final Region region;
  final Mountain? parent;

  MountainGraph._(map, this.aliases, this.maps, this.classifications,
      this.countries, this.region, this.parent)
      : super(map);

  factory MountainGraph(
      Map<String, dynamic> map,
      List<String> aliases,
      List<OsMap> maps,
      List<Classification> classifications,
      List<Country> countries,
      Region region,
      Mountain? parent) {
    return MountainGraph._(
        map, aliases, maps, classifications, countries, region, parent);
  }
}
