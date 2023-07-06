import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';

import 'rotate_with_map.dart';
import '../../models/mountain.dart';
import '../shared/mountain_height.dart';

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
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
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
                    content: Height(height: mountain.height),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      FilledButton.icon(
                        icon: const Icon(Icons.chevron_right),
                        label: const Text('More'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushNamed('/mountains', arguments: mountain.id);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
