import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import '../config.dart';
import '../widgets/sm_app_bar.dart';

class Loading extends StatelessWidget {
  Loading({super.key}) {
    copyDbToAppData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SmAppBar(),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Loading'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Increment',
        child: const Icon(Icons.replay_circle_filled),
      ),
    );
  }

  void copyDbToAppData() async {
    var directory = await getApplicationDocumentsDirectory();
    var file = File('${directory.path}/${Config.dbFileName}');

    if (await file.exists()) {
      await file.delete();
    }

    final bytes = await rootBundle.load("assets/${Config.dbFileName}");
    final buffer = bytes.buffer;
    await file.writeAsBytes(
        buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));

    print(file.path);
  }
}
