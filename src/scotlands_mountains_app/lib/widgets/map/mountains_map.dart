import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:scotlands_mountains_app/widgets/map/map_controls.dart';
import 'mapbox_attribution.dart';
import 'mapbox_tile_layer.dart';
import 'mountain_layer.dart';

import '../../models/mountain.dart';
import 'scalebar.dart';

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

  final _mapController = MapController();

  Layer _selectedLayer = Layer.outdoors;
  bool _isControllerReady = false;
  StreamSubscription<MapEvent>? _subscription;
  MapOptions? _mapOptions;

  @override
  void initState() {
    super.initState();

    _mapOptions = MapOptions(
      maxBounds: LatLngBounds(LatLng(54, -9), LatLng(61, 0)),
      minZoom: 6,
      maxZoom: 18,
      onMapReady: () {
        setState(() {
          _isControllerReady = true;
          _subscription = _mapController.mapEventStream.listen((event) {
            if (event is MapEventRotate) {
              setState(() {});
            }
          });
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final fitBounds = LatLngBounds(
        LatLng(
          widget.mountains.map((m) => m.latitude).reduce(min),
          widget.mountains.map((m) => m.longitude).reduce(min),
        ),
        LatLng(
          widget.mountains.map((m) => m.latitude).reduce(max),
          widget.mountains.map((m) => m.longitude).reduce(max),
        ));

    if (_isControllerReady) {
      _mapController.fitBounds(fitBounds,
          options: const FitBoundsOptions(forceIntegerZoomLevel: true));
    }

    return FlutterMap(
      mapController: _mapController,
      options: _mapOptions!,
      nonRotatedChildren: [
        Scalebar(
            options: ScalebarOptions(
          lineColor: Colors.white,
          lineWidth: 2,
          textStyle: const TextStyle(color: Colors.white, fontSize: 12),
          padding: const EdgeInsets.all(8),
        )),
        const MapboxAttribution(),
        MapControls(
          onReset: () {
            _mapController.rotate(0);
            _mapController.fitBounds(fitBounds,
                options: const FitBoundsOptions(forceIntegerZoomLevel: true));
          },
          onSelectOutdoors: () {
            setState(() {
              _selectedLayer = Layer.outdoors;
            });
          },
          onSelectSatellite: () {
            setState(() {
              _selectedLayer = Layer.satellite;
            });
          },
          onSelectStreets: () {
            setState(() {
              _selectedLayer = Layer.streets;
            });
          },
        )
      ],
      children: [
        _layers[_selectedLayer]!,
        MountainLayer(
          mapController: _mapController,
          mountains: widget.mountains,
        ),
      ],
    );
  }
}
