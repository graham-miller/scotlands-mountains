import 'package:flutter/material.dart';
import '../repositories/data.dart';
import '../widgets/sm_app_bar.dart';

class Loading extends StatefulWidget {
  final Function initializationCompleteCallback;

  Loading({Key? key, required this.initializationCompleteCallback})
      : super(key: key) {
    copyDbToAppData();
  }

  void copyDbToAppData() async {
    await Data().initialize();
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
    return Scaffold(
        appBar: const SmAppBar(),
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
