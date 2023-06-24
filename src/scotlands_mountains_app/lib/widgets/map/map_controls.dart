import 'package:flutter/material.dart';
import 'package:scotlands_mountains_app/widgets/map/mountains_map.dart';

import '../expandible_fab.dart';

class MapControls extends StatelessWidget {
  final void Function() onReset;

  const MapControls({super.key, required this.onReset});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpandableFab(
        distance: 112,
        children: [
          ActionButton(
            onPressed: () {},
            icon: const Icon(Icons.map),
          ),
          ActionButton(
            onPressed: () {},
            icon: const Icon(Icons.satellite),
          ),
          ActionButton(
            onPressed: () {},
            icon: const Icon(Icons.directions_car_filled),
          ),
          ActionButton(
            onPressed: onReset,
            icon: const Icon(Icons.restore),
          ),
        ],
      ),
    );
  }
}

/*
FloatingActionButton(
              onPressed: onReset,
              child: const Icon(Icons.restore),
            )
*/
