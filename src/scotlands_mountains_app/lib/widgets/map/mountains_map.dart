import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:scotlands_mountains_app/widgets/map/map_controls.dart';
import 'mapbox_attribution.dart';
import 'mapbox_tile_layer.dart';
import 'mountain_layer.dart';

import '../../models/mountain.dart';

class MountainsMap extends StatefulWidget {
  final List<Mountain> mountains;

  const MountainsMap({super.key, required this.mountains});

  @override
  State<MountainsMap> createState() => _MountainsMapState();
}

enum Layer { outdoors, streets, satellite, satelliteStreets }

class _MountainsMapState extends State<MountainsMap> {
  final Map<Layer, TileLayer> _layers = {
    Layer.outdoors: MapboxTileLayer(styleId: 'outdoors-v12'),
    Layer.streets: MapboxTileLayer(styleId: 'streets-v12'),
    Layer.satellite: MapboxTileLayer(styleId: 'satellite-v9'),
    Layer.satelliteStreets: MapboxTileLayer(styleId: 'satellite-streets-v12'),
  };

  final _defaultCenter = LatLng(56.816922, -4.18265);
  final _defaultZoom = 7.0;
  final _defaultRotation = 0.0;
  final _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    final mapOptions = MapOptions(
      maxBounds: LatLngBounds(LatLng(54, -9), LatLng(61, 0)),
      center: _defaultCenter,
      zoom: _defaultZoom,
      onMapReady: () {
        _mapController.mapEventStream.listen((event) {
          if (event is MapEventRotate) {
            setState(() {});
          }
        });
      },
    );

    return FlutterMap(
      mapController: _mapController,
      options: mapOptions,
      nonRotatedChildren: [
        const MapboxAttribution(),
        MapControls(
          onReset: () {
            _mapController.move(_defaultCenter, _defaultZoom);
            _mapController.rotate(_defaultRotation);
          },
        )
      ],
      children: [
        _layers[Layer.outdoors]!,
        MountainLayer(
          mapController: _mapController,
          mountains: widget.mountains,
        ),
      ],
    );
  }
}
