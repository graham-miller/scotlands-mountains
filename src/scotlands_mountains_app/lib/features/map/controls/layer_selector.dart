import 'package:flutter/material.dart';

import 'animated_control.dart';
import 'map_interactions.dart';

class LayerSelector extends StatelessWidget {
  final Animation<double> animation;
  final MapInteractions mapInteractions;
  final Axis axis;
  final double openPosition;

  const LayerSelector({
    required this.animation,
    required this.mapInteractions,
    required this.axis,
    required this.openPosition,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedControl(
      animation: animation,
      axis: axis,
      openPosition: openPosition,
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        clipBehavior: Clip.antiAlias,
        color: const Color.fromRGBO(255, 255, 255, 0.8),
        child: ToggleButtons(
          direction: Axis.horizontal,
          onPressed: (int index) {
            switch (index) {
              case 0:
                mapInteractions.selectStreets();
                break;
              case 1:
                mapInteractions.selectSatelliteStreets();
                break;
              case 2:
                mapInteractions.selectSatellite();
                break;
              default:
                mapInteractions.selectOutdoors();
                break;
            }
          },
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          selectedColor: Theme.of(context).colorScheme.onPrimary,
          fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.8),
          isSelected: List.from([
            mapInteractions.selectedLayer == Layer.streets,
            mapInteractions.selectedLayer == Layer.satelliteStreets,
            mapInteractions.selectedLayer == Layer.satellite,
            mapInteractions.selectedLayer == Layer.outdoors,
          ]),
          children: const [
            Icon(Icons.drive_eta_outlined),
            Icon(Icons.add_photo_alternate_outlined),
            Icon(Icons.image_outlined),
            Icon(Icons.map_outlined),
          ],
        ),
      ),
    );
  }
}
