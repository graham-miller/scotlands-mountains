import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';

import '../mountains/app_pop_up.dart';
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
            if (showInfo) {
              AppPopUp.open(
                title: mountain.name,
                content: Util.formatHeight(mountain.height),
                action: () {
                  Navigator.of(context)
                      .pushNamed('/mountains', arguments: mountain.id);
                },
                actionLabel: 'More',
                context: context,
              );
            }
          },
        ),
      ),
    );
  }
}
