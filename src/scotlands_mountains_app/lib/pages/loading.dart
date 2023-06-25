import 'package:flutter/material.dart';
import '../repositories/data.dart';
import '../widgets/app_scaffold.dart';

class Loading extends StatefulWidget {
  final Function initializationCompleteCallback;

  Loading({Key? key, required this.initializationCompleteCallback})
      : super(key: key) {
    copyDbToAppData();
  }

  void copyDbToAppData() async {
    await Data().initialize();
    await Future.delayed(const Duration(seconds: 1));
    initializationCompleteCallback();
  }

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });
    _controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            value: _controller.value,
            semanticsLabel: 'Circular progress indicator',
          ),
        ],
      ),
    ));
  }
}
