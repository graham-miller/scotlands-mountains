import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/os_map.dart';

class OrderedMaps extends StatelessWidget {
  final scaleFormat = NumberFormat("#,###", "en_GB");
  final List<OsMap> maps;

  OrderedMaps({super.key, required this.maps});

  @override
  Widget build(BuildContext context) {
    final ordered = maps;
    ordered.sort((a, b) {
      final scaleComparison = a.scale.compareTo(b.scale);
      if (scaleComparison == 0) {
        return a.code.compareTo(b.code);
      }
      return scaleComparison;
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: ordered.map((m) {
        return Text(
            '${m.code}${m.name != null ? ' ${m.name!}' : ''} (1:${scaleFormat.format((1 / m.scale).round())})');
      }).toList(),
    );
  }
}
