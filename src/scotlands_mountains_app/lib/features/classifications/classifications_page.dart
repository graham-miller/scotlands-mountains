import 'package:flutter/material.dart';

import '../../repositories/mountains_repository.dart';
import 'classification_selector.dart';
import '../../models/classification.dart';
import '../../models/mountain.dart';
import '../../repositories/classifications_repository.dart';
import '../map/mountains_map.dart';
import 'mountains_list.dart';

class ClassificationsPage extends StatefulWidget {
  const ClassificationsPage({super.key});

  @override
  State<ClassificationsPage> createState() => _ClassificationsPageState();
}

class _ClassificationsPageState extends State<ClassificationsPage> {
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
          ClassificationSelector(
              onClassificationSelected: (c) => _loadMountains(c)),
          const TabBar(
            tabs: [
              Tab(text: 'List', icon: Icon(Icons.list)),
              Tab(text: 'Map', icon: Icon(Icons.map)),
            ],
          ),
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