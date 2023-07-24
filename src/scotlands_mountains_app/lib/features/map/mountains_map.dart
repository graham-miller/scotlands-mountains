import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:scotlands_mountains_app/features/map/controls/map_interactions.dart';
import 'package:scotlands_mountains_app/features/map/mapbox_tile_layer.dart';

import 'controls/expanding_fab.dart';
import 'mapbox_attribution.dart';
import 'mountain_layer.dart';
import '../../models/mountain.dart';
import 'scalebar/scalebar.dart';

class MountainsMap extends StatefulWidget {
  final List<Mountain> mountains;
  final bool showInfo;

  const MountainsMap(
      {super.key, required this.mountains, this.showInfo = true});

  @override
  State<MountainsMap> createState() => _MountainsMapState();
}

class _MountainsMapState extends State<MountainsMap> {
  final _mapController = MapController();
  late final MapOptions _mapOptions;
  late final MapInteractions _mapInteractions;

  @override
  void initState() {
    super.initState();
    _mapOptions = MapOptions(
      center: MapInteractions.defaultCenter,
      zoom: MapInteractions.defaultZoom,
      minZoom: 5,
      maxZoom: 18,
      onTap: (_, __) {
        ScaffoldMessenger.of(context).clearSnackBars();
      },
      onMapReady: () {
        _mapInteractions.setCenterZoom(widget.mountains);
      },
      onPositionChanged: (_, __) {
        _mapInteractions.onPositionChanged();
      },
      onMapEvent: (event) {
        if (event is MapEventRotate) {
          if (_mapInteractions.canRotate) {
            setState(() {});
          } else if (_mapController.rotation != 0) {
            _mapController.rotate(0);
          }
        }
      },
    );
    _mapInteractions = MapInteractions(
        mapController: _mapController,
        mapOptions: _mapOptions,
        redrawMap: () => setState(() {}));
  }

  @override
  void didUpdateWidget(MountainsMap oldWidget) {
    _mapInteractions.setCenterZoom(widget.mountains);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: _mapOptions,
      nonRotatedChildren: [
        Scalebar(
          options: ScalebarOptions(
            lineColor: Colors.white,
            lineWidth: 2,
            textStyle: const TextStyle(color: Colors.white, fontSize: 12),
            padding: const EdgeInsets.all(8),
          ),
        ),
        const MapboxAttribution(),
        ExpandingFab(mapInteractions: _mapInteractions)
      ],
      children: [
        MapboxTileLayer.layers[_mapInteractions.selectedLayer]!,
        MountainLayer(
          mapController: _mapController,
          mountains: widget.mountains,
          showInfo: widget.showInfo,
        ),
      ],
    );
  }
}
