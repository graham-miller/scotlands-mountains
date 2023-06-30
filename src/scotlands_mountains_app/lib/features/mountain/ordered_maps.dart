import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/os_map.dart';
import '../shared/util.dart';

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

    return Wrap(
      direction: Axis.horizontal,
      spacing: 4,
      runSpacing: -2,
      children: ordered.map((m) {
        return TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith((states) =>
                  Theme.of(context).colorScheme.onSecondaryContainer),
              backgroundColor: MaterialStateProperty.resolveWith(
                  (states) => Theme.of(context).colorScheme.secondaryContainer),
            ),
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text('${m.code} ${m.name}'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Publisher: ${m.publisher}'),
                      Text('Series: ${m.series}'),
                      Text(
                          'Scale: 1:${scaleFormat.format((1 / m.scale).round())}'),
                      Text('ISBN: ${m.isbn}'),
                      const Text(''),
                      const Text(
                          'We use affiliate links to amazon.co.uk so when you buy a map linked from here we receive a small commission payment which helps support the development of Scotland\'s Mountains.')
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Buy'),
                      onPressed: () {
                        Util.openInBrowser(
                            'https://www.amazon.co.uk/s?k=${m.isbn}');
                      },
                    ),
                    TextButton(
                      child: const Text('Close'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            },
            child: Text('${m.code} ${m.name}'));
      }).toList(),
    );
  }
}
