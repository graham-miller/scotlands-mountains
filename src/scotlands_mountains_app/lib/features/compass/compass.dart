import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

import 'face.dart';
import 'needle.dart';

class Compass extends StatelessWidget {
  const Compass({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          const Face(),
          Transform.rotate(
            angle: radians(42.5),
            child: const Needle(),
          ),
        ],
      ),
    );
  }
}
