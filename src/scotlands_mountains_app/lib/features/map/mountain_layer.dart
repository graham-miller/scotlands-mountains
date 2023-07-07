import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';

import '../shared/util.dart';
import 'rotate_with_map.dart';
import '../../models/mountain.dart';

class MountainLayer extends StatelessWidget {
  final MapController mapController;
  final List<Mountain> mountains;
  final bool showInfo;

  const MountainLayer(
      {super.key,
      required this.mapController,
      required this.mountains,
      this.showInfo = true});

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
        markers: mountains.map((m) => _buildMarker(m, context)).toList(),
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
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Marker _buildMarker(Mountain mountain, BuildContext context) {
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
          onTap: () {
            if (!showInfo) {
              return;
            }
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Theme.of(context).colorScheme.background,
                closeIconColor: Theme.of(context).colorScheme.onBackground,
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mountain.name,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      Util.formatHeight(mountain.height),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).clearSnackBars();
                          },
                          child: const Text('Close'),
                        ),
                        FilledButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            Navigator.of(context).pushNamed('/mountains',
                                arguments: mountain.id);
                          },
                          child: const Text('More'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
