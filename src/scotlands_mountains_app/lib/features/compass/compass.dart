import 'dart:async';

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
  double _needleDegrees = 0.00;
  double _bezelDegrees = 0.00;
  StreamSubscription<CompassEvent>? subscription;

  @override
  void initState() {
    subscription = FlutterCompass.events?.listen((event) {
      setState(() {
        _needleDegrees = -1 * (event.heading ?? 0.0);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Bearing: ${(360 - _bezelDegrees).round().toString()}'),
          ],
        ),
        Expanded(
          child: GestureDetector(
            onPanUpdate: (details) => _updateBearing(details),
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.expand,
              children: [
                Transform.rotate(
                  angle: radians(_bezelDegrees),
                  child: const Face(),
                ),
                Transform.rotate(
                  angle: radians(_needleDegrees),
                  child: const Needle(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _updateBearing(DragUpdateDetails details) {
    final quadrant =
        details.localPosition.dy < ((context.size?.height ?? 0) / 2)
            ? details.localPosition.dx < ((context.size?.width ?? 0) / 2)
                ? 4
                : 1
            : details.localPosition.dx < ((context.size?.width ?? 0) / 2)
                ? 3
                : 2;

    final horizontal = details.delta.dx < 0
        ? -1
        : details.delta.dx > 0
            ? 1
            : 0;

    final vertical = details.delta.dy < 0
        ? -1
        : details.delta.dy > 0
            ? 1
            : 0;

    int direction = 0;

    if (quadrant == 1) {
      if (horizontal > 0 || vertical > 0) {
        direction = 1;
      } else if (horizontal < 0 || vertical < 0) {
        direction = -1;
      }
    } else if (quadrant == 2) {
      if (horizontal < 0 || vertical > 0) {
        direction = 1;
      } else if (horizontal > 0 || vertical < 0) {
        direction = -1;
      }
    } else if (quadrant == 3) {
      if (horizontal < 0 || vertical < 0) {
        direction = 1;
      } else if (horizontal > 0 || vertical > 0) {
        direction = -1;
      }
    } else if (quadrant == 4) {
      if (horizontal > 0 || vertical < 0) {
        direction = 1;
      } else if (horizontal < 0 || vertical > 0) {
        direction = -1;
      }
    }

    var newBearing =
        _bezelDegrees += (details.localPosition.direction * direction);
    if (newBearing < 0) {
      newBearing += 360;
    } else if (newBearing > 360) {
      newBearing -= 360;
    }

    setState(() {
      _bezelDegrees = newBearing;
    });
  }
}
