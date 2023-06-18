import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Data {
  static const String _dbFileName = 'scotlands_mountains.db';

  static final Data _instance = Data._internal();

  factory Data() {
    return _instance;
  }

  Data._internal();

  String? _path;

  Future initialize() async {
    _path = join(await getDatabasesPath(), _dbFileName);

    var file = File(_path!);

    if (await file.exists()) {
      await file.delete();
    }

    final bytes = await rootBundle.load("assets/$_dbFileName");
    final buffer = bytes.buffer;
    await file.writeAsBytes(
        buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
  }

  Future<Database> getDatabase() async {
    if (_path == null) {
      await initialize();
    }

    return await openDatabase(_path!);
  }
}
