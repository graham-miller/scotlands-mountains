import 'package:flutter/material.dart';
import 'package:scotlands_mountains_app/features/mountain_list/list_or_map_of_mountains.dart';

import '../repositories/mountains_repository.dart';
import '../features/mountain_list/classification_selector.dart';
import '../models/classification.dart';
import '../models/mountain.dart';
import '../repositories/classifications_repository.dart';
import '../features/map/mountains_map.dart';
import '../features/mountain_list/mountains_list.dart';

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
    _loadMountains(null);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClassificationSelector(
          onClassificationSelected: (c) => _loadMountains(c),
        ),
        ListOrMapOfMountains(
          list: MountainsList(mountains: _mountains),
          map: MountainsMap(mountains: _mountains),
        ),
      ],
    );
  }
}
