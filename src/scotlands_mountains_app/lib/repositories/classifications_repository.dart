import '../models/classification.dart';
import 'data.dart';

class ClassificationsRepository {
  Future<Classification> getDefault() async {
    final db = await Data().getDatabase();

    return _toEntities(await db.query('Classifications',
            where: 'DisplayOrder IS NOT NULL',
            orderBy: 'DisplayOrder',
            limit: 1))
        .single;
  }

  Future<Classification> get(String id) async {
    final db = await Data().getDatabase();

    return _toEntities(await db.query('Classifications',
            where: 'Id = ?', whereArgs: [id], limit: 1))
        .single;
  }

  List<Classification> _toEntities(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      return Classification(
        id: maps[i]['id'],
        displayOrder: maps[i]['displayOrder'],
        isActive: maps[i]['isActive'],
        nameSingular: maps[i]['nameSingular'],
        description: maps[i]['description'],
        name: maps[i]['name'],
      );
    });
  }
}
