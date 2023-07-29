import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

import '../features/compass/compass.dart';

class CompassPage extends StatelessWidget {
  const CompassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Transform.rotate(
            angle: radians(0),
            child: const Compass(),
          ),
        )
      ],
    );
  }
}
