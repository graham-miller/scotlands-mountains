import 'package:flutter/material.dart';

import '../../models/classification.dart';

class OrderedClassifications extends StatelessWidget {
  final List<Classification> classifications;

  const OrderedClassifications({super.key, required this.classifications});

  @override
  Widget build(BuildContext context) {
    final ordered = classifications;
    ordered.sort((a, b) => a.displayOrder!.compareTo(b.displayOrder!));

    return Wrap(
      direction: Axis.horizontal,
      spacing: 4,
      runSpacing: -2,
      children: ordered.map(
        (c) {
          return OutlinedButton(
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text(c.name),
                  content: Text(c.description),
                  actions: <Widget>[
                    FilledButton(
                      child: const Text('Close'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            },
            child: Text(c.nameSingular),
          );
        },
      ).toList(),
    );
  }
}
