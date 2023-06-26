import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../repositories/data.dart';
import '../widgets/app_scaffold.dart';

class Loading extends StatefulWidget {
  final Function initializationCompleteCallback;

  Loading({Key? key, required this.initializationCompleteCallback})
      : super(key: key) {
    copyDbToAppData();
  }

  void copyDbToAppData() async {
    await Future.wait(
        [Data().initialize(), Future.delayed(const Duration(seconds: 5))]);
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
    _controller.repeat(reverse: false);
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
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Stack(children: [
            SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(
                strokeWidth: 8,
                value: _controller.value,
                semanticsLabel: 'Circular progress indicator',
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 18, 20, 20),
              child: SvgPicture.asset(
                'assets/logo.svg',
                height: 60,
                colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary, BlendMode.srcIn),
              ),
            )
          ]),
        ],
      ),
    ));
  }
}
