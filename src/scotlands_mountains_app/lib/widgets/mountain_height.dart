import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/mountain.dart';

class MountainsHeight extends StatelessWidget {
  final Mountain mountain;
  final heightFormat = NumberFormat("#,###", "en_GB");

  MountainsHeight({super.key, required this.mountain});

  @override
  Widget build(BuildContext context) {
    return Text(
        '${heightFormat.format(mountain.height)}m (${heightFormat.format(mountain.height * 3.28084)}ft)');
  }
}
