import 'package:flutter/material.dart';

import '../models/mountain.dart';
import '../repositories/mountains_repository.dart';
import '../widgets/mountain_height.dart';

class MountainPage extends StatefulWidget {
  final int id;

  const MountainPage({super.key, required this.id});

  @override
  State<MountainPage> createState() => _MountainPageState();
}

class _MountainPageState extends State<MountainPage> {
  Mountain? _mountain;

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
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text('Name'),
          subtitle: Text(_mountain != null ? _mountain!.name : ''),
        ),
        ListTile(
          title: const Text('Height'),
          subtitle:
              _mountain != null ? Height(height: _mountain!.height) : null,
        ),
        ListTile(
          title: const Text('Latitude, longitude'),
          subtitle: Text(_mountain != null
              ? '${_mountain!.latitude}, ${_mountain!.longitude}'
              : ''),
        ),
        ListTile(
          title: const Text('Grid ref.'),
          subtitle: Text(_mountain != null ? _mountain!.gridRef : ''),
        ),
        ListTile(
          title: const Text('Summit features'),
          subtitle: Text(_mountain != null ? _mountain!.feature ?? '' : ''),
        ),
        ListTile(
          title: const Text('Summit observations'),
          subtitle:
              Text(_mountain != null ? _mountain!.observations ?? '' : ''),
        ),
        ListTile(
          title: const Text('Drop'),
          subtitle: _mountain != null ? Height(height: _mountain!.drop) : null,
        ),
        ListTile(
          title: const Text('Col'),
          subtitle: Text(_mountain != null ? _mountain!.col : ''),
        ),
        ListTile(
          title: const Text('Col height'),
          subtitle:
              _mountain != null ? Height(height: _mountain!.colHeight) : null,
        ),
      ],
    );
  }

/*
      this.drop,
      this.col,
      this.colHeight,
*/
}