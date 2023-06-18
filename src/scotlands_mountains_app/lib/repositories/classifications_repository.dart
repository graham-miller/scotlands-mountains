import '../models/classification.dart';
import 'data.dart';

class ClassificationsRepository {
  Future<Classification> getDefault() async {
    const sql = '''
      SELECT *
      FROM Classifications
      WHERE displayOrder IS NOT NULL
      ORDER BY displayOrder ASC
      LIMIT 1
    ''';

    final db = await Data().getDatabase();

    return Classification((await db.rawQuery(sql)).single);
  }
}
