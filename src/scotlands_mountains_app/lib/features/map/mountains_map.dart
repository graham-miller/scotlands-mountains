import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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

enum Layer { outdoors, streets, satellite, satelliteStreets }

class _MountainsMapState extends State<MountainsMap> {
  final Map<Layer, TileLayer> _layers = {
    Layer.outdoors: MapboxTileLayer(styleId: 'outdoors-v12'),
    Layer.streets: MapboxTileLayer(styleId: 'streets-v12'),
    Layer.satellite: MapboxTileLayer(styleId: 'satellite-v9'),
    Layer.satelliteStreets: MapboxTileLayer(styleId: 'satellite-streets-v12'),
  };
  final _fitBoundOptions = const FitBoundsOptions(
    padding: EdgeInsets.fromLTRB(8, 8, 8, 70),
    forceIntegerZoomLevel: true,
  );
  final _maxBounds = LatLngBounds(LatLng(54, -9), LatLng(61, 0));
  final _defaultCenter = LatLng(56.816922, -4.18265);
  final _defaultZoom = 6.0;
  final _mapController = MapController();
  late final MapOptions _mapOptions;

  Layer _selectedLayer = Layer.outdoors;
  StreamSubscription<MapEvent>? _subscription;
  CenterZoom? _centerZoom;
  bool _canZoomIn = true;
  bool _canZoomOut = true;

  @override
  void initState() {
    super.initState();
    _mapOptions = MapOptions(
      maxBounds: _maxBounds,
      center: _defaultCenter,
      zoom: _defaultZoom,
      minZoom: 5,
      maxZoom: 18,
      interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
      onTap: (_, __) {
        ScaffoldMessenger.of(context).clearSnackBars();
      },
      onMapReady: () {
        setState(
          () {
            _calculateCenterZoom();
            _mapController.move(_centerZoom!.center, _centerZoom!.zoom);
            _subscription = _mapController.mapEventStream.listen(
              (event) {
                if (event is MapEventRotate) {
                  setState(() {});
                }
              },
            );
          },
        );
      },
    );
  }

  @override
  void didUpdateWidget(MountainsMap oldWidget) {
    _calculateCenterZoom();
    _mapController.move(_centerZoom!.center, _centerZoom!.zoom);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _subscription?.cancel();
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
        )),
        const MapboxAttribution(),
        MapControls(
          onReset: () {
            setState(() {
              _canZoomIn = true;
              _canZoomOut = true;
            });
            _mapController.rotate(0);
            _mapController.move(_centerZoom!.center, _centerZoom!.zoom);
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
          zoomIn: () {
            _mapController.move(_mapController.center, _mapController.zoom + 1);
            setState(() {
              _canZoomOut = true;
              _canZoomIn = _mapController.zoom < _mapOptions.maxZoom! - 1;
            });
          },
          zoomOut: () {
            _mapController.move(_mapController.center, _mapController.zoom - 1);
            setState(() {
              _canZoomIn = true;
              _canZoomOut = _mapController.zoom > _mapOptions.minZoom! + 1;
            });
          },
          canZoomIn: _canZoomIn,
          canZoomOut: _canZoomOut,
        )
      ],
      children: [
        _layers[_selectedLayer]!,
        MountainLayer(
          mapController: _mapController,
          mountains: widget.mountains,
          showInfo: widget.showInfo,
        ),
      ],
    );
  }

  void _calculateCenterZoom() {
    if (widget.mountains.isEmpty) {
      _centerZoom = CenterZoom(center: _defaultCenter, zoom: _defaultZoom);
    } else {
      LatLngBounds? fitBounds;
      if (widget.mountains.length == 1) {
        final mountain = widget.mountains.single;
        fitBounds = LatLngBounds(
            LatLng(mountain.latitude - 0.01, mountain.longitude - 0.01),
            LatLng(mountain.latitude + 0.01, mountain.longitude + 0.01));
      } else {
        fitBounds = LatLngBounds(
            LatLng(
              widget.mountains.map((m) => m.latitude).reduce(min),
              widget.mountains.map((m) => m.longitude).reduce(min),
            ),
            LatLng(
              widget.mountains.map((m) => m.latitude).reduce(max),
              widget.mountains.map((m) => m.longitude).reduce(max),
            ));
      }
      _centerZoom = _mapController.centerZoomFitBounds(fitBounds,
          options: _fitBoundOptions);
    }
  }
}
