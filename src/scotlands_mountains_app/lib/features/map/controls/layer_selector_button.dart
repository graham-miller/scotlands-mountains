import 'package:flutter/material.dart';
import 'map_controls_facade.dart';

class LayerSelectorButton extends StatelessWidget {
  final Animation<double> animation;
  final MapControlsFacade mapControlsFacade;
  final Axis axis;
  final double openPosition;

  const LayerSelectorButton({
    required this.animation,
    required this.mapControlsFacade,
    required this.axis,
    required this.openPosition,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: animation.value > 0,
      child: Positioned(
        right: axis == Axis.vertical ? 4 : animation.value * openPosition,
        bottom: axis == Axis.horizontal ? 4 : animation.value * openPosition,
        child: Material(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          clipBehavior: Clip.antiAlias,
          color: const Color.fromRGBO(255, 255, 255, 0.8),
          child: ToggleButtons(
            direction: Axis.horizontal,
            onPressed: (int index) {
              switch (index) {
                case 0:
                  mapControlsFacade.selectStreets();
                  break;
                case 1:
                  mapControlsFacade.selectSatelliteStreets();
                  break;
                case 2:
                  mapControlsFacade.selectSatellite();
                  break;
                default:
                  mapControlsFacade.selectOutdoors();
                  break;
              }
            },
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            selectedColor: Theme.of(context).colorScheme.onPrimary,
            fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.8),
            isSelected: List.from([
              mapControlsFacade.selectedLayer == Layer.streets,
              mapControlsFacade.selectedLayer == Layer.satelliteStreets,
              mapControlsFacade.selectedLayer == Layer.satellite,
              mapControlsFacade.selectedLayer == Layer.outdoors,
            ]),
            children: const [
              Icon(Icons.drive_eta_outlined),
              Icon(Icons.add_photo_alternate_outlined),
              Icon(Icons.image_outlined),
              Icon(Icons.map_outlined),
            ],
          ),
        ),
      ),
    );
  }
}
