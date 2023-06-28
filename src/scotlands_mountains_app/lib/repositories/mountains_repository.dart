import '../models/mountain.dart';
import 'data.dart';

class MountainsRepository {
  Future<Mountain> get(int id) async {
    const sql = '''
      SELECT *
      FROM Mountains m
      WHERE id = ?
      ''';
    final db = await Data().getDatabase();

    return Mountain((await db.rawQuery(sql, [id])).single);
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
}
