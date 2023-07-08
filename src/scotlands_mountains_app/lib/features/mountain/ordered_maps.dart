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
      runSpacing: 4,
      children: ordered.map(
        (map) {
          return _buildButton(
            map: map,
            context: context,
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text('${map.code} ${map.name}'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Publisher: ${map.publisher}'),
                      Text('Series: ${map.series}'),
                      Text(
                          'Scale: 1:${scaleFormat.format((1 / map.scale).round())}'),
                      Text('ISBN: ${map.isbn}'),
                      const Text(''),
                      const Text(
                          'We use affiliate links so when you buy a map we receive a small commission at no additional cost to you which helps support the development of Scotland\'s Mountains.')
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Close'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FilledButton.icon(
                      icon: const Icon(Icons.shopping_cart),
                      label: const Text('Buy'),
                      onPressed: () {
                        Util.openInBrowser(
                            'https://www.amazon.co.uk/s?k=${map.isbn}');
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ).toList(),
    );
  }

  Widget _buildButton(
      {required OsMap map,
      required Function onPressed,
      required BuildContext context}) {
    Color typeColor;
    Color textColor;
    if (map.series == 'Explorer') {
      if (map.code.startsWith('OL')) {
        typeColor = const Color.fromRGBO(255, 237, 0, 1);
        textColor = Colors.black;
      } else {
        typeColor = const Color.fromRGBO(236, 99, 8, 1);
        textColor = Colors.white;
      }
    } else {
      typeColor = const Color.fromRGBO(229, 0, 124, 1);
      textColor = Colors.white;
    }

    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: GestureDetector(
          onTap: () {
            onPressed();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(8, 8, 4, 8),
                decoration: BoxDecoration(
                  color: typeColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                  border: Border.all(
                    color: typeColor,
                    width: 1,
                  ),
                ),
                width: 50,
                alignment: Alignment.center,
                child: Text(
                  map.code,
                  style:
                      TextStyle(color: textColor, fontWeight: FontWeight.bold),
                ),
              ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(4, 8, 8, 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    border: Border.all(
                      color: typeColor,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    map.name,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
