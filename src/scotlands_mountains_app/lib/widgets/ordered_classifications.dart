import 'package:flutter/material.dart';

import '../models/classification.dart';

class OrderedClassifications extends StatelessWidget {
  final List<Classification> classifications;

  const OrderedClassifications({super.key, required this.classifications});

  @override
  Widget build(BuildContext context) {
    final ordered = classifications;
    ordered.sort((a, b) => a.displayOrder!.compareTo(b.displayOrder!));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: ordered.map((c) {
        return GestureDetector(
            child: Row(
              children: [
                Text(c.nameSingular),
                const Icon(Icons.info_outlined, size: 18),
              ],
            ),
            onTap: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: Text(c.name),
                      content: Text(c.description),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Close'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    )));
      }).toList(),
    );
  }
}
