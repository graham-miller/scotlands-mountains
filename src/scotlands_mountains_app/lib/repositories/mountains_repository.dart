import '../models/mountain.dart';
import 'data.dart';

class MountainsRepository {
  Future<Mountain> get(String id) async {
    final db = await Data().getDatabase();

    return _toEntities(await db.query('Moutains',
            where: 'Id = ?', whereArgs: [id], limit: 1))
        .single;
  }

  List<Mountain> _toEntities(List<Map<String, dynamic>> maps) {
    return List.generate(maps.length, (i) {
      return Mountain(
        id: maps[i]['id'],
        latitude: maps[i]['latitude'],
        longitude: maps[i]['longitude'],
        gridRef: maps[i]['gridRef'],
        height: maps[i]['height'],
        feature: maps[i]['feature'],
        observations: maps[i]['observations'],
        drop: maps[i]['drop'],
        col: maps[i]['col'],
        colHeight: maps[i]['colHeight'],
        parentId: maps[i]['parentId'],
        aliases: maps[i]['aliases'],
        regionId: maps[i]['regionId'],
        dobihId: maps[i]['dobihId'],
        name: maps[i]['name'],
      );
    });
  }
}
