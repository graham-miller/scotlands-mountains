import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:scotlands_mountains_app/widgets/mountain_height.dart';

import '../models/mountain.dart';

class MountainsMap extends StatelessWidget {
  final List<Mountain> mountains;
  final accessToken = dotenv.env['MAPBOX_PUBLIC_ACCESS_TOKEN'] ?? '';
  // https://docs.mapbox.com/api/maps/static-tiles/
  //mapbox://styles/mapbox/outdoors-v12
  final url =
      'https://api.mapbox.com/styles/v1/mapbox/outdoors-v12/tiles/512/{z}/{x}/{y}@2x?access_token=';
  final mapBounds = LatLngBounds(LatLng(54, -9), LatLng(61, 0));
  final mapCenter = LatLng(56.816922, -4.18265);
  final mapZoom = 7.0;

  MountainsMap({super.key, required this.mountains});

  @override
  Widget build(BuildContext context) {
    final mapController = MapController();
    final mapOptions = MapOptions(
      maxBounds: mapBounds,
      center: mapCenter,
      zoom: mapZoom,
    );

    return FlutterMap(
      mapController: mapController,
      options: mapOptions,
      children: [
        TileLayer(urlTemplate: url + accessToken),
        MarkerClusterLayerWidget(
            options: getMarkerClusterLayerOptions(context)),
      ],
    );
  }

  MarkerClusterLayerOptions getMarkerClusterLayerOptions(BuildContext context) {
    return MarkerClusterLayerOptions(
      maxClusterRadius: 45,
      size: const Size(30, 30),
      anchor: AnchorPos.align(AnchorAlign.center),
      fitBoundsOptions: const FitBoundsOptions(
        padding: EdgeInsets.all(50),
        maxZoom: 15,
      ),
      markers: mountains.map((m) => getMarker(m, context)).toList(),
      builder: (context, markers) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.purple),
          child: Center(
            child: Text(
              markers.length.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  Marker getMarker(Mountain mountain, BuildContext context) {
    return Marker(
        point: LatLng(mountain.latitude, mountain.longitude),
        height: mountain.height,
        builder: (x) => GestureDetector(
              child: const Icon(
                Icons.place,
                size: 30,
                color: Colors.purple,
              ),
              onTap: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text(mountain.name),
                  content: MountainsHeight(mountain: mountain),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Close'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ));
  }
}
