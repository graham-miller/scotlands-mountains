import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:scotlands_mountains_app/features/map/controls/map_controls_facade.dart';

import './controls/map_controls.dart';
import 'mapbox_attribution.dart';
import 'mapbox_tile_layer.dart';
import 'mountain_layer.dart';
import '../../models/mountain.dart';
import 'scalebar.dart';

class MountainsMap extends StatefulWidget {
  final List<Mountain> mountains;
  final bool showInfo;

  const MountainsMap(
      {super.key, required this.mountains, this.showInfo = true});

  @override
  State<MountainsMap> createState() => _MountainsMapState();
}

class _MountainsMapState extends State<MountainsMap> {
  final Map<Layer, TileLayer> _layers = {
    Layer.streets: MapboxTileLayer(styleId: 'streets-v12'),
    Layer.satelliteStreets: MapboxTileLayer(styleId: 'satellite-streets-v12'),
    Layer.satellite: MapboxTileLayer(styleId: 'satellite-v9'),
    Layer.outdoors: MapboxTileLayer(styleId: 'outdoors-v12'),
  };
  final _mapController = MapController();
  late final MapOptions _mapOptions;
  late final MapControlsFacade _mapControlsFacade;

  @override
  void initState() {
    super.initState();
    _mapOptions = MapOptions(
      center: MapControlsFacade.defaultCenter,
      zoom: MapControlsFacade.defaultZoom,
      minZoom: 5,
      maxZoom: 18,
      interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
      onTap: (_, __) {
        ScaffoldMessenger.of(context).clearSnackBars();
      },
      onMapReady: () {
        _mapControlsFacade.setCenterZoom(widget.mountains);
      },
      onPositionChanged: (_, __) {
        _mapControlsFacade.onPositionChanged();
      },
      onMapEvent: (event) {
        if (event is MapEventRotate) {
          setState(() {});
        }
      },
    );
    _mapControlsFacade = MapControlsFacade(
        mapController: _mapController,
        mapOptions: _mapOptions,
        redrawMap: () => setState(() {}));
  }

  @override
  void didUpdateWidget(MountainsMap oldWidget) {
    _mapControlsFacade.setCenterZoom(widget.mountains);
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
        MapControls(mapControlsFacade: _mapControlsFacade)
      ],
      children: [
        _layers[_mapControlsFacade.selectedLayer]!,
        MountainLayer(
          mapController: _mapController,
          mountains: widget.mountains,
          showInfo: widget.showInfo,
        ),
      ],
    );
  }
}
