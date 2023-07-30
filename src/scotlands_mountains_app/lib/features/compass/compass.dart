import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:vector_math/vector_math_64.dart';

import 'face.dart';
import 'needle.dart';

class Compass extends StatefulWidget {
  const Compass({super.key});

  @override
  State<Compass> createState() => _CompassState();
}

class _CompassState extends State<Compass> {
  double _heading = 0.00;
  double _bearing = 0.00;

  @override
  void initState() {
    FlutterCompass.events?.listen((event) {
      setState(() {
        _heading = event.heading ?? 0.0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) => _updateBearing(details),
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Transform.rotate(
            angle: radians(_bearing),
            child: const Face(),
          ),
          Transform.rotate(
            angle: -1 * radians(_heading),
            child: const Needle(),
          ),
        ],
      ),
    );
  }

  void _updateBearing(DragUpdateDetails details) {
    var quadrant = details.localPosition.dy < ((context.size?.height ?? 0) / 2)
        ? details.localPosition.dx < ((context.size?.width ?? 0) / 2)
            ? 4
            : 1
        : details.localPosition.dx < ((context.size?.width ?? 0) / 2)
            ? 3
            : 2;

    print(quadrant.toString());

    setState(() {
      _bearing += details.localPosition.direction;
    });
  }
}
