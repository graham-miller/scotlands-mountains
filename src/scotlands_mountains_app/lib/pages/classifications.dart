import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:intl/intl.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:scotlands_mountains_app/repositories/mountains_repository.dart';
import 'package:scotlands_mountains_app/widgets/classification_selector.dart';
import '../models/classification.dart';
import '../models/mountain.dart';
import '../repositories/classifications_repository.dart';
import '../widgets/sm_app_bar.dart';

class Classifications extends StatefulWidget {
  const Classifications({super.key});

  @override
  State<Classifications> createState() => _ClassificationsState();
}

class _ClassificationsState extends State<Classifications> {
  List<Mountain> _mountains = List.empty();
  int tabIndex = 0;

  _ClassificationsState() {
    _loadMountains(null);
  }

  void _loadMountains(Classification? classification) async {
    classification ??= await ClassificationsRepository().getDefault();
    final mountains =
        await MountainsRepository().getByClassificationId(classification.id);

    setState(() {
      _mountains = mountains;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadMountains(null);
  }

  Widget getMap() {
    var mapController = MapController();
    var mapOptions = MapOptions(
      maxBounds: LatLngBounds(LatLng(54, -9), LatLng(61, 0)),
      center: LatLng(56.816922, -4.18265),
      zoom: 7,
    );

    final accessToken = dotenv.env['MAPBOX_PUBLIC_ACCESS_TOKEN'] ?? '';
    // https://docs.mapbox.com/api/maps/static-tiles/
    //mapbox://styles/mapbox/outdoors-v12
    final url =
        'https://api.mapbox.com/styles/v1/mapbox/outdoors-v12/tiles/512/{z}/{x}/{y}@2x?access_token=' +
            accessToken;
    final heightFormat = NumberFormat("#,###", "en_GB");

    var markers = _mountains
        .map((m) => Marker(
            point: LatLng(m.latitude, m.longitude),
            height: m.height,
            builder: (x) => GestureDetector(
                  child: const Icon(
                    Icons.place,
                    size: 30,
                    color: Colors.purple,
                  ),
                  onTap: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text(m.name),
                      content: Text(
                          '${heightFormat.format(m.height)}m (${heightFormat.format(m.height * 3.28084)}ft)'),
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
                )))
        .toList();

    return FlutterMap(
      mapController: mapController,
      options: mapOptions,
      children: [
        TileLayer(
          urlTemplate: url,
        ),
        // MarkerLayer(markers: markers)
        MarkerClusterLayerWidget(
          options: MarkerClusterLayerOptions(
            maxClusterRadius: 45,
            size: const Size(30, 30),
            anchor: AnchorPos.align(AnchorAlign.center),
            fitBoundsOptions: const FitBoundsOptions(
              padding: EdgeInsets.all(50),
              maxZoom: 15,
            ),
            markers: markers,
            builder: (context, markers) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.purple),
                child: Center(
                  child: Text(
                    markers.length.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final heightFormat = NumberFormat("#,###", "en_GB");

    return Scaffold(
      appBar: const SmAppBar(),
      body: Column(
        children: [
          ClassificationSelector(
              onClassificationSelected: (c) => _loadMountains(c)),
          Expanded(
            child: getMap(),
          ),
          // child: ListView.builder(
          //   itemCount: _mountains.length,
          //   itemBuilder: (context, index) {
          //     return ListTile(
          //       leading: CircleAvatar(child: Text(((index) + 1).toString())),
          //       title: Text(_mountains[index].name),
          //       subtitle: Text(
          //           '${heightFormat.format(_mountains[index].height)}m (${heightFormat.format(_mountains[index].height * 3.28084)}ft)'),
          //       trailing: const Icon(Icons.more_vert),
          //     );
          //   },
          //   ),
          // ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Map',
            ),
          ],
          currentIndex: tabIndex,
          onTap: (i) => setState(() {
                tabIndex = i;
              })),
    );
  }
}
