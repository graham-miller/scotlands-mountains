import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/mountain.dart';
import '../common/util.dart';

class Prominence extends StatelessWidget {
  final scaleFormat = NumberFormat("#,###", "en_GB");
  final Mountain mountain;

  Prominence({super.key, required this.mountain});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text(Util.formatHeight(mountain.drop)),
        const Text(' from '),
        Text(mountain.col),
        const Text(' at'),
        const Text(' height'),
        const Text(' of '),
        Text(Util.formatHeight(mountain.colHeight)),
        const Text('.'),
      ],
    );
  }
}
