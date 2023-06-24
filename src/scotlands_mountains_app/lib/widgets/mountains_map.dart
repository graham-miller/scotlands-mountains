import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:scotlands_mountains_app/widgets/mountain_height.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/mountain.dart';

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
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        Image.asset('assets/mapbox-logo-white.png', height: 25),
                  ),
                  Icon(Icons.info_outline, color: Colors.white)
                ],
              ),
              onTap: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title:
                      Image.asset('assets/mapbox-logo-black.png', height: 25),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('© Mapbox'),
                      const Text('© OpenStreetMap'),
                      const Text('Improve this map'),
                    ],
                  ),
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
          ],
        )
      ],
      children: [
        TileLayer(urlTemplate: _url + _accessToken),
        getMarkerClusterLayer(context),
      ],
    );
  }

  Widget getMarkerClusterLayer(BuildContext context) {
    return MarkerClusterLayerWidget(
        options: MarkerClusterLayerOptions(
            maxClusterRadius: 45,
            size: const Size(30, 30),
            anchor: AnchorPos.align(AnchorAlign.center),
            fitBoundsOptions: const FitBoundsOptions(
              padding: EdgeInsets.all(50),
              maxZoom: 15,
            ),
            markers:
                widget.mountains.map((m) => getMarker(m, context)).toList(),
            builder: (context, markers) {
              return rotateWithMap(
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
        builder: (x) => rotateWithMap(
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

  Widget rotateWithMap({required Widget child}) {
    return Transform.rotate(
        angle: -_mapController.rotation * math.pi / 180, child: child);
  }
}
