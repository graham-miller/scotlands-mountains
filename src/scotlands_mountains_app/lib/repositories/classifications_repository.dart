import '../models/classification.dart';
import 'data.dart';

class ClassificationsRepository {
  Future<Classification> getDefault() async {
    const sql = '''
      SELECT *
      FROM Classifications
      WHERE isActive = 1
      ORDER BY displayOrder ASC
      LIMIT 1
    ''';

    final db = await Data().getDatabase();

    return Classification((await db.rawQuery(sql).then((x) => x.single)));
  }

  Future<List<Classification>> getAll() async {
    const sql = '''
      SELECT *
      FROM Classifications
      WHERE isActive =1
      ORDER BY displayOrder ASC
    ''';

    final db = await Data().getDatabase();

    return (await db.rawQuery(sql)).map((map) => Classification(map)).toList();
  }
}
