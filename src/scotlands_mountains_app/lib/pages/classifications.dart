import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
      maxBounds: LatLngBounds(const LatLng(54, -9), const LatLng(61, 0)),
      center: const LatLng(56.816922, -4.18265),
      zoom: 7,
    );

    final accessToken = dotenv.env['MAPBOX_PUBLIC_ACCESS_TOKEN'] ?? '';
    // https://docs.mapbox.com/api/maps/static-tiles/
    //mapbox://styles/mapbox/outdoors-v12
    final url =
        'https://api.mapbox.com/styles/v1/mapbox/outdoors-v12/tiles/512/{z}/{x}/{y}@2x?access_token=' +
            accessToken;

    return FlutterMap(
      mapController: mapController,
      options: mapOptions,
      children: [
        TileLayer(
          urlTemplate: url,
        ),
        MarkerLayer(
            markers: _mountains
                .map((m) => Marker(
                    point: LatLng(m.latitude, m.longitude),
                    height: m.height,
                    builder: (x) => const Icon(
                          Icons.place,
                          size: 30,
                          color: Colors.purple,
                        )))
                .toList())
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
