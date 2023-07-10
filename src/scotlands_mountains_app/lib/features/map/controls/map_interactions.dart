import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../models/mountain.dart';

enum Layer { streets, satelliteStreets, satellite, outdoors }

class MapInteractions {
  static final defaultCenter = LatLng(56.816922, -4.18265);
  static const defaultZoom = 6.0;
  final _fitBoundOptions = const FitBoundsOptions(
    padding: EdgeInsets.fromLTRB(8, 8, 8, 70),
    forceIntegerZoomLevel: true,
  );

  final MapController mapController;
  final MapOptions mapOptions;
  final Function redrawMap;

  late CenterZoom centerZoom;
  bool canZoomIn = true;
  bool canZoomOut = true;
  bool canRotate = false;
  Layer selectedLayer = Layer.outdoors;

  MapInteractions(
      {required this.mapController,
      required this.mapOptions,
      required this.redrawMap}) {
    centerZoom = CenterZoom(
      center: defaultCenter,
      zoom: defaultZoom,
    );
  }

  void onPositionChanged() {
    canZoomIn = mapController.zoom < mapOptions.maxZoom!;
    canZoomOut = mapController.zoom > mapOptions.minZoom!;
    redrawMap();
  }

  void reset() {
    mapController.rotate(0);
    mapController.move(centerZoom.center, centerZoom.zoom);
    redrawMap();
  }

  void selectOutdoors() {
    selectedLayer = Layer.outdoors;
    redrawMap();
  }

  void selectSatellite() {
    selectedLayer = Layer.satellite;
    redrawMap();
  }

  void selectSatelliteStreets() {
    selectedLayer = Layer.satelliteStreets;
    redrawMap();
  }

  void selectStreets() {
    selectedLayer = Layer.streets;
    redrawMap();
  }

  void zoomIn() {
    mapController.move(mapController.center, mapController.zoom + 1);
  }

  void zoomOut() {
    mapController.move(mapController.center, mapController.zoom - 1);
  }

  void enableRotation() {
    canRotate = true;
  }

  void disableRotation() {
    mapController.rotate(0);
    canRotate = false;
  }

  void setCenterZoom(List<Mountain> mountains) {
    if (mountains.isEmpty) {
      centerZoom = CenterZoom(center: defaultCenter, zoom: defaultZoom);
    } else {
      LatLngBounds? fitBounds;
      if (mountains.length == 1) {
        final mountain = mountains.single;
        fitBounds = LatLngBounds(
            LatLng(mountain.latitude - 0.01, mountain.longitude - 0.01),
            LatLng(mountain.latitude + 0.01, mountain.longitude + 0.01));
      } else {
        fitBounds = LatLngBounds(
            LatLng(
              mountains.map((m) => m.latitude).reduce(min),
              mountains.map((m) => m.longitude).reduce(min),
            ),
            LatLng(
              mountains.map((m) => m.latitude).reduce(max),
              mountains.map((m) => m.longitude).reduce(max),
            ));
      }
      centerZoom = mapController.centerZoomFitBounds(fitBounds,
          options: _fitBoundOptions);
      reset();
    }
  }
}
