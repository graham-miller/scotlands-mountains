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
    return const Scaffold(
        appBar: SmAppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Loading'),
            ],
          ),
        ));
  }

  void copyDbToAppData() async {
    await Data().initialize();

    initializationCompleteCallback();
  }
}
