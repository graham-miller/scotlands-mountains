import 'package:flutter/material.dart';

import '../features/compass/compass.dart';

class CompassPage extends StatelessWidget {
  const CompassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Compass(),
      ],
    );
  }
}
