import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:scotlands_mountains_app/repositories/classifications_repository.dart';
import 'package:scotlands_mountains_app/repositories/mountains_repository.dart';
import 'package:scotlands_mountains_app/widgets/classification_selector.dart';
import '../models/classification.dart';
import '../models/mountain.dart';
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

  void _onMapCreated(MapboxMap mapboxMap) {
    print('map created');
    mapboxMap.setBounds(CameraBoundsOptions(
        bounds: CoordinateBounds(
            southwest: Point(coordinates: Position(-9, 54)).toJson(),
            northeast: Point(coordinates: Position(0, 61)).toJson(),
            infiniteBounds: false)));
    mapboxMap.setCamera(CameraOptions(
        zoom: 6,
        center: Point(coordinates: Position(-4.18265, 56.816922)).toJson()));
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
            child: MapWidget(
              resourceOptions: ResourceOptions(
                  accessToken: dotenv.env['MAPBOX_PUBLIC_ACCESS_TOKEN'] ?? ''),
              onMapCreated: _onMapCreated,
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
            // ),
          ),
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
