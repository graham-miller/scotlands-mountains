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
    final mountainMaps = (await db.rawQuery(sql, [id])).single;
    final aliases = await _getAliases(id);
    final maps = await _getOsMaps(id);
    final classifications = await _getClassifications(id);
    final countries = await _getCountries(id);
    final region = await _getRegion(id);

    return MountainGraph(
        mountainMaps, aliases, maps, classifications, countries, region);
  }

  Future<List<Mountain>> getByClassificationId(int id) async {
    const sql = '''
      SELECT m.*
      FROM Mountains m
      INNER JOIN MountainClassifications mc ON m.id = mc.mountainsId
      INNER JOIN Classifications c ON mc.classificationsId = c.id
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
      WHERE name LIKE ?
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

    return (await db.rawQuery(sql, [arg])).map((map) => Mountain(map)).toList();
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
      SELECT m.*
      FROM Maps m
      INNER JOIN MountainMaps mm ON m.id == mm.mapsId
      WHERE mm.mountainsId = ?
      ''';
    final db = await Data().getDatabase();

    return (await db.rawQuery(sql, [id])).map((map) => OsMap(map)).toList();
  }

  Future<List<Classification>> _getClassifications(int id) async {
    const sql = '''
      SELECT c.*
      FROM Classifications c
      INNER JOIN MountainClassifications mc ON c.id == mc.classificationsId
      WHERE mc.mountainsId = ?
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

    return (await db.rawQuery(sql, [id])).map((map) => Region(map)).single;
  }
}
