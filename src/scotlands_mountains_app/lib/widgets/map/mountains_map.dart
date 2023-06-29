import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'map_controls.dart';
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
  final _fitBoundOptions = const FitBoundsOptions(
    padding: EdgeInsets.all(8.0),
    forceIntegerZoomLevel: true,
  );
  final _maxBounds = LatLngBounds(LatLng(54, -9), LatLng(61, 0));

  final _mapController = MapController();

  Layer _selectedLayer = Layer.outdoors;
  StreamSubscription<MapEvent>? _subscription;
  MapOptions? _mapOptions;
  LatLngBounds? _fitBounds;

  @override
  void initState() {
    super.initState();
    _calculateFitBounds();
    _mapOptions = MapOptions(
      maxBounds: _maxBounds,
      bounds: _fitBounds,
      boundsOptions: _fitBoundOptions,
      minZoom: 6,
      maxZoom: 18,
      onMapReady: () {
        setState(() {
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
  void didUpdateWidget(MountainsMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    _calculateFitBounds();
    final centerZoom = _mapController.centerZoomFitBounds(_fitBounds!,
        options: _fitBoundOptions);
    _mapController.move(centerZoom.center, centerZoom.zoom);
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
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
            _mapController.fitBounds(_fitBounds!,
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

  void _calculateFitBounds() {
    if (widget.mountains.isEmpty) {
      _fitBounds = _maxBounds;
    } else if (widget.mountains.length == 1) {
      final mountain = widget.mountains.single;
      _fitBounds = LatLngBounds(
          LatLng(mountain.latitude - 0.01, mountain.longitude - 0.01),
          LatLng(mountain.latitude + 0.01, mountain.longitude + 0.01));
    } else {
      _fitBounds = LatLngBounds(
          LatLng(
            widget.mountains.map((m) => m.latitude).reduce(min),
            widget.mountains.map((m) => m.longitude).reduce(min),
          ),
          LatLng(
            widget.mountains.map((m) => m.latitude).reduce(max),
            widget.mountains.map((m) => m.longitude).reduce(max),
          ));
    }
  }
}
