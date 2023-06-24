import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:scotlands_mountains_app/widgets/map/rotate_with_map.dart';

import '../../models/mountain.dart';
import '../mountain_height.dart';

class MountainLayer extends StatelessWidget {
  final MapController mapController;
  final List<Mountain> mountains;

  const MountainLayer(
      {super.key, required this.mapController, required this.mountains});

  @override
  Widget build(BuildContext context) {
    return MarkerClusterLayerWidget(
        options: MarkerClusterLayerOptions(
            maxClusterRadius: 45,
            size: const Size(30, 30),
            anchor: AnchorPos.align(AnchorAlign.center),
            fitBoundsOptions: const FitBoundsOptions(
              padding: EdgeInsets.all(50),
              maxZoom: 15,
            ),
            markers: mountains.map((m) => getMarker(m, context)).toList(),
            builder: (context, markers) {
              return RotateWithMap(
                mapController: mapController,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).primaryColor),
                  child: Center(
                    child: Text(
                      markers.length.toString(),
                      style: TextStyle(color: Theme.of(context).indicatorColor),
                    ),
                  ),
                ),
              );
            }));
  }

  Marker getMarker(Mountain mountain, BuildContext context) {
    return Marker(
        point: LatLng(mountain.latitude, mountain.longitude),
        height: mountain.height,
        builder: (x) => RotateWithMap(
              mapController: mapController,
              child: GestureDetector(
                child: Icon(
                  Icons.place,
                  size: 30,
                  color: Theme.of(context).primaryColor,
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
              ),
            ));
  }
}
