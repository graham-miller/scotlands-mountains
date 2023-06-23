import 'package:flutter/material.dart';
import 'package:scotlands_mountains_app/repositories/mountains_repository.dart';
import 'package:scotlands_mountains_app/widgets/classification_selector.dart';
import '../models/classification.dart';
import '../models/mountain.dart';
import '../repositories/classifications_repository.dart';
import '../widgets/mountains_map.dart';
import '../widgets/sm_app_bar.dart';
import '../widgets/mountains_list.dart';

class Classifications extends StatefulWidget {
  const Classifications({super.key});

  @override
  State<Classifications> createState() => _ClassificationsState();
}

class _ClassificationsState extends State<Classifications> {
  List<Mountain> _mountains = List.empty();
  bool showMap = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SmAppBar(),
      body: Column(
        children: [
          ClassificationSelector(
              onClassificationSelected: (c) => _loadMountains(c)),
          Expanded(
              child: showMap
                  ? MountainsMap(mountains: _mountains)
                  : MountainsList(mountains: _mountains)),
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
          currentIndex: showMap ? 1 : 0,
          onTap: (i) => setState(() {
                showMap = i == 1;
              })),
    );
  }
}
