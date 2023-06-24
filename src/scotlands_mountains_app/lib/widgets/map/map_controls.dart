import 'package:flutter/material.dart';

class MapControls extends StatelessWidget {
  final void Function() onReset;

  const MapControls({super.key, required this.onReset});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: onReset,
              child: const Icon(Icons.restore),
            ),
          ),
        ],
      ),
    ]);
  }
}
