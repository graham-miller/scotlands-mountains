import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../map/controls/map_interactions.dart';
import '../map/mapbox_attribution.dart';
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
        nonRotatedChildren: const [MapboxAttribution()],
        children: [
          MapboxTileLayer.layers[Layer.streets]!,
          PolygonLayer(
            polygons:
                AreaMapConstants.metadata.values.map((e) => e.polygon).toList(),
          ),
          MarkerLayer(
            markers: AreaMapConstants.metadata.values
                .map((e) => _buildMarker(
                    point: e.center,
                    text: (e.index + 1).toString(),
                    onPressed: () => onSelected(e.index)))
                .toList(),
          )
        ],
      ),
    );
  }

  Marker _buildMarker(
      {required LatLng point,
      required String text,
      required Function onPressed}) {
    return Marker(
      point: point,
      builder: (_) => GestureDetector(
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
      ),
    );
  }
}
