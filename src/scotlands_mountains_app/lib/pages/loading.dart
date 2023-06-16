import 'package:flutter/material.dart';
import '../repositories/data.dart';
import '../widgets/sm_app_bar.dart';

class Loading extends StatelessWidget {
  Loading({Key? key, required this.initializationCompleteCallback})
      : super(key: key) {
    copyDbToAppData();
  }

  final Function initializationCompleteCallback;

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
    await Data().initialize();

    initializationCompleteCallback();
  }
}
