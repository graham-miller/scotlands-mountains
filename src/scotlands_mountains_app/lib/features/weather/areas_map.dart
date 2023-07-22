import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../map/controls/map_interactions.dart';
import '../map/mapbox_tile_layer.dart';
import 'areas_map_constants.dart';

class AreasMap extends StatelessWidget {
  final Null Function(int i) onSelected;

  const AreasMap({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FlutterMap(
        options: MapOptions(
          center: MapInteractions.defaultCenter,
          zoom: MapInteractions.defaultZoom,
          interactiveFlags: 0,
        ),
        nonRotatedChildren: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        Image.asset('assets/mapbox-logo-white.png', height: 25),
                  ),
                ],
              ),
            ],
          ),
        ],
        children: [
          MapboxTileLayer(styleId: 'streets-v12'),
          PolygonLayer(
            polygons: AreaMapConstants.polygons(),
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(57.6779, -5.2214),
                builder: (_) =>
                    _buildMarker(text: '1', onPressed: () => onSelected(0)),
              ),
              Marker(
                point: LatLng(57.1225, -4.0237),
                builder: (_) =>
                    _buildMarker(text: '2', onPressed: () => onSelected(1)),
              ),
              Marker(
                point: LatLng(56.6975, -3.3733),
                builder: (_) =>
                    _buildMarker(text: '3', onPressed: () => onSelected(2)),
              ),
              Marker(
                point: LatLng(56.2051, -5.4379),
                builder: (_) =>
                    _buildMarker(text: '4', onPressed: () => onSelected(3)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildMarker({required String text, required Function onPressed}) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
