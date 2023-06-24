import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class RotateWithMap extends StatelessWidget {
  final MapController mapController;
  final Widget child;

  const RotateWithMap(
      {super.key, required this.mapController, required this.child});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
        angle: -mapController.rotation * math.pi / 180, child: child);
  }
}
