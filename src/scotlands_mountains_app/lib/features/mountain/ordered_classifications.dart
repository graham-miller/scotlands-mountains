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
      runSpacing: 2,
      children: ordered.map(
        (classification) {
          return _buildButton(
            classification: classification,
            context: context,
            onPressed: () {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: Text(classification.name),
                        content: Text(classification.description),
                        actions: <Widget>[
                          FilledButton(
                            child: const Text('Close'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ));
            },
          );
        },
      ).toList(),
    );
  }

  Widget _buildButton(
      {required Classification classification,
      required Function onPressed,
      required BuildContext context}) {
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: GestureDetector(
        onTap: () {
          onPressed();
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 1,
            ),
          ),
          child: Text(
            classification.nameSingular,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer),
          ),
        ),
      ),
    );
  }
}
