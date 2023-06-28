import 'package:flutter/material.dart';
import 'package:scotlands_mountains_app/repositories/mountains_repository.dart';
import 'package:scotlands_mountains_app/widgets/classification_selector.dart';
import '../models/classification.dart';
import '../models/mountain.dart';
import '../repositories/classifications_repository.dart';
import '../widgets/map/mountains_map.dart';
import '../widgets/mountains_list.dart';

class Classifications extends StatefulWidget {
  const Classifications({super.key});

  @override
  State<Classifications> createState() => _ClassificationsState();
}

class _ClassificationsState extends State<Classifications> {
  List<Mountain> _mountains = List.empty();

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
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'List', icon: Icon(Icons.list)),
              Tab(text: 'Map', icon: Icon(Icons.map)),
            ],
          ),
          ClassificationSelector(
              onClassificationSelected: (c) => _loadMountains(c)),
          Expanded(
              child: TabBarView(children: [
            MountainsList(mountains: _mountains),
            MountainsMap(mountains: _mountains),
          ]))
        ],
      ),
    );
  }
}
