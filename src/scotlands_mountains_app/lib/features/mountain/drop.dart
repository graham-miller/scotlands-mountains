import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/mountain.dart';
import '../shared/mountain_height.dart';

class Drop extends StatelessWidget {
  final scaleFormat = NumberFormat("#,###", "en_GB");
  final Mountain mountain;

  Drop({super.key, required this.mountain});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Height(height: mountain.drop),
        const Text(' from '),
        Text(mountain.col),
        const Text(' at'),
        const Text(' height'),
        const Text(' of '),
        Height(height: mountain.colHeight),
        const Text('.'),
      ],
    );
  }
}
