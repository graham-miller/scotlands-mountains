import '../models/classification.dart';
import 'data.dart';

class ClassificationsRepository {
  Future<Classification> getDefault() async {
    final db = await Data().getDatabase();

    final List<Map<String, dynamic>> maps = await db.query('Classifications',
        where: 'DisplayOrder IS NOT NULL', orderBy: 'DisplayOrder', limit: 1);

    return List.generate(maps.length, (i) {
      return Classification(
        id: maps[i]['Id'],
        displayOrder: maps[i]['DisplayOrder'],
        isActive: maps[i]['IsActive'],
        nameSingular: maps[i]['NameSingular'],
        description: maps[i]['Description'],
        name: maps[i]['Name'],
      );
    })[0];
  }
}
