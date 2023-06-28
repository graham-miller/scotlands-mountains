import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Height extends StatelessWidget {
  final double height;
  final heightFormat = NumberFormat("#,###", "en_GB");

  Height({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Text(
        '${heightFormat.format(height)}m (${heightFormat.format(height * 3.28084)}ft)');
  }
}
