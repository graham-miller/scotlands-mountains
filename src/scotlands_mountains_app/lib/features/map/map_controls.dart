import 'package:flutter/material.dart';

import 'expandible_fab.dart';

class MapControls extends StatelessWidget {
  final void Function() onReset;
  final void Function() onSelectOutdoors;
  final void Function() onSelectSatellite;
  final void Function() onSelectStreets;

  const MapControls({
    super.key,
    required this.onReset,
    required this.onSelectOutdoors,
    required this.onSelectSatellite,
    required this.onSelectStreets,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpandableFab(
        distance: 112,
        children: [
          ActionButton(
            onPressed: onSelectOutdoors,
            icon: const Icon(Icons.map),
          ),
          ActionButton(
            onPressed: onSelectSatellite,
            icon: const Icon(Icons.satellite),
          ),
          ActionButton(
            onPressed: onSelectStreets,
            icon: const Icon(Icons.directions_car_filled),
          ),
          ActionButton(
            onPressed: onReset,
            icon: const Icon(Icons.settings_backup_restore),
          ),
        ],
      ),
    );
  }
}
