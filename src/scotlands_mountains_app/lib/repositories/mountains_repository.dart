import '../models/mountain.dart';
import 'data.dart';

class MountainsRepository {
  Future<List<Mountain>> getByClassificationId(int id) async {
    const sql = '''
      SELECT m.*
      FROM Mountains m
      INNER JOIN MountainClassifications mc ON m.id = mc.mountainsId
      INNER JOIN Classifications c ON mc.classificationsId = c.id
      WHERE c.id = ?
      ORDER BY m.height DESC
      ''';
    final db = await Data().getDatabase();

    return (await db.rawQuery(sql, [id])).map((map) => Mountain(map)).toList();
  }
}
