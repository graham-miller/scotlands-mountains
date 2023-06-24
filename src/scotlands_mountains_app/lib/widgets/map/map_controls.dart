import 'package:flutter/material.dart';
import 'package:scotlands_mountains_app/widgets/map/mountains_map.dart';

class MapControls extends StatelessWidget {
  final void Function() onReset;

  const MapControls({super.key, required this.onReset});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // https://docs.flutter.dev/cookbook/effects/expandable-fab
            PopupMenuButton<Layer>(
              color: Theme.of(context).primaryColor,
              initialValue: Layer.outdoors,
              onSelected: (Layer layer) {
                print(layer);
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Layer>>[
                const PopupMenuItem<Layer>(
                  value: Layer.outdoors,
                  child: Text('Outdoors'),
                ),
                const PopupMenuItem<Layer>(
                  value: Layer.streets,
                  child: Text('Streets'),
                ),
                const PopupMenuItem<Layer>(
                  value: Layer.satellite,
                  child: Text('Satellite'),
                ),
              ],
            ),
          ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: onReset,
              child: const Icon(Icons.restore),
            ),
          )
        ]),
      ],
    );
  }
}
