import 'package:flutter/material.dart';
import 'package:scotlands_mountains_app/features/map/mountains_map.dart';

import '../models/mountain_graph.dart';
import '../repositories/mountains_repository.dart';
import '../features/common/util.dart';
import '../features/mountain/mountain_details.dart';
import '../features/mountain/mountain_photos/mountain_photos.dart';

class MountainPage extends StatefulWidget {
  final int id;

  const MountainPage({super.key, required this.id});

  @override
  State<MountainPage> createState() => _MountainPageState();
}

class _MountainPageState extends State<MountainPage>
    with SingleTickerProviderStateMixin {
  MountainGraph? _mountain;
  late TabController _tabController;

  void _loadMountain() async {
    final mountain = await MountainsRepository().get(widget.id);

    setState(() {
      _mountain = mountain;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadMountain();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _mountain == null
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _mountain!.name,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
        _mountain == null
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(Util.formatHeight(_mountain!.height)),
              ),
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Details', icon: Icon(Icons.list)),
            Tab(text: 'Photos', icon: Icon(Icons.photo)),
            Tab(text: 'Map', icon: Icon(Icons.map)),
          ],
        ),
        Expanded(
          child: _mountain == null
              ? const SizedBox.shrink()
              : TabBarView(controller: _tabController, children: [
                  MountainDetails(mountain: _mountain!),
                  MountainPhotos(mountain: _mountain!),
                  MountainsMap(mountains: [_mountain!], showInfo: false),
                ]),
        ),
      ],
    );
  }
}
