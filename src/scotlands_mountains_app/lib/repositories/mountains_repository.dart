import '../models/classification.dart';
import '../models/country.dart';
import '../models/mountain.dart';
import '../models/mountain_graph.dart';
import '../models/os_map.dart';
import '../models/region.dart';
import 'data.dart';

class MountainsRepository {
  Future<MountainGraph> get(int id) async {
    final db = await Data().getDatabase();

    const sql = '''
      SELECT *
      FROM Mountains m
      WHERE id = ?
      ''';

    final mountain = db.rawQuery(sql, [id]).then((x) => x.single);
    final aliases = _getAliases(id);
    final maps = _getOsMaps(id);
    final classifications = _getClassifications(id);
    final countries = _getCountries(id);
    final region = _getRegion(id);

    var graph = await Future.wait(
        [mountain, aliases, maps, classifications, countries, region]);

    return MountainGraph(
        graph.elementAt(0) as Map<String, dynamic>,
        graph.elementAt(1) as List<String>,
        graph.elementAt(2) as List<OsMap>,
        graph.elementAt(3) as List<Classification>,
        graph.elementAt(4) as List<Country>,
        graph.elementAt(5) as Region);
  }

  Future<List<Mountain>> getByClassificationId(int id) async {
    const sql = '''
      SELECT m.*
      FROM Mountains m
      INNER JOIN MountainClassifications mc ON m.id = mc.mountainId
      INNER JOIN Classifications c ON mc.classificationId = c.id
      WHERE c.id = ?
      AND m.id IN (
        SELECT DISTINCT mountainsId
        FROM Countries co
        INNER JOIN MountainCountries mco ON co.id = mco.countriesId
        WHERE co.isEnabled = 1
      )
      ORDER BY m.height DESC
      ''';
    final db = await Data().getDatabase();

    return (await db.rawQuery(sql, [id])).map((map) => Mountain(map)).toList();
  }

  Future<List<Mountain>> search(String term) async {
    final arg = '%$term%';

    const sql = '''
      SELECT *
      FROM Mountains
      WHERE (
        name LIKE ?
        OR
        id IN (
          SELECT mountainId
          FROM Aliases
          WHERE name LIKE ?
        )
      )
      AND id IN (
        SELECT DISTINCT mountainsId
        FROM Countries co
        INNER JOIN MountainCountries mco ON co.id = mco.countriesId
        WHERE co.isEnabled = 1
      )
      ORDER BY height DESC
      LIMIT 500
      ''';
    final db = await Data().getDatabase();

    return (await db.rawQuery(sql, [arg, arg]))
        .map((map) => Mountain(map))
        .toList();
  }

  Future<List<String>> _getAliases(int id) async {
    const sql = '''
      SELECT *
      FROM Aliases
      WHERE mountainId = ?
      ORDER BY name ASC
      ''';
    final db = await Data().getDatabase();

    final result = await db.rawQuery(sql, [id]);

    return result.map((map) => map['name'] as String).toList();
  }

  Future<List<OsMap>> _getOsMaps(int id) async {
    const sql = '''
      SELECT m.*, s.scale, s.name AS series, p.name AS publisher
      FROM Maps m
      INNER JOIN MountainMaps mm ON m.id == mm.mapsId
      INNER JOIN MapSeries s ON m.seriesId = s.id
      INNER JOIN MapPublishers p ON s.publisherId = p.id
      WHERE mm.mountainsId = ?
      ''';
    final db = await Data().getDatabase();

    return (await db.rawQuery(sql, [id])).map((map) => OsMap(map)).toList();
  }

  Future<List<Classification>> _getClassifications(int id) async {
    const sql = '''
      SELECT c.*
      FROM Classifications c
      INNER JOIN MountainClassifications mc ON c.id == mc.classificationId
      WHERE mc.mountainId = ?
      AND c.isActive = 1
      ORDER BY displayOrder ASC
      ''';
    final db = await Data().getDatabase();

    return (await db.rawQuery(sql, [id]))
        .map((map) => Classification(map))
        .toList();
  }

  Future<List<Country>> _getCountries(int id) async {
    const sql = '''
      SELECT c.*
      FROM Countries c
      INNER JOIN MountainCountries mc ON c.id == mc.countriesId
      WHERE mc.mountainsId = ?
      AND c.isEnabled = 1
      ''';
    final db = await Data().getDatabase();

    return (await db.rawQuery(sql, [id])).map((map) => Country(map)).toList();
  }

  Future<Region> _getRegion(int id) async {
    const sql = '''
      SELECT r.*
      FROM Regions r
      INNER JOIN Mountains m ON r.id == m.regionId
      WHERE m.Id = ?
      ''';
    final db = await Data().getDatabase();

    return Region(await db.rawQuery(sql, [id]).then((x) => x.single));
  }
}
