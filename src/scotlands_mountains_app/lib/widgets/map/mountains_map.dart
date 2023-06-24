import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:scotlands_mountains_app/widgets/map/map_controls.dart';
import 'mapbox_attribution.dart';
import 'mountain_layer.dart';

import '../../models/mountain.dart';

class MountainsMap extends StatefulWidget {
  final List<Mountain> mountains;

  const MountainsMap({super.key, required this.mountains});

  @override
  State<MountainsMap> createState() => _MountainsMapState();
}

class _MountainsMapState extends State<MountainsMap> {
  final _accessToken = dotenv.env['MAPBOX_PUBLIC_ACCESS_TOKEN'] ?? '';

  // https://docs.mapbox.com/api/maps/static-tiles/
  final _url =
      'https://api.mapbox.com/styles/v1/mapbox/outdoors-v12/tiles/512/{z}/{x}/{y}@2x?access_token=';

  final _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    final mapOptions = MapOptions(
      maxBounds: LatLngBounds(LatLng(54, -9), LatLng(61, 0)),
      center: LatLng(56.816922, -4.18265),
      zoom: 7,
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
            _mapController.move(LatLng(56.816922, -4.18265), 7);
          },
        )
      ],
      children: [
        TileLayer(urlTemplate: _url + _accessToken),
        MountainLayer(
          mapController: _mapController,
          mountains: widget.mountains,
        ),
      ],
    );
  }
}
