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
        id: maps[i]['Id'],
        displayOrder: maps[i]['DisplayOrder'],
        isActive: maps[i]['IsActive'],
        nameSingular: maps[i]['NameSingular'],
        description: maps[i]['Description'],
        name: maps[i]['Name'],
      );
    });
  }
}
