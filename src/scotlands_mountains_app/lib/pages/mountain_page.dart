import 'package:flutter/material.dart';
import 'package:scotlands_mountains_app/widgets/ordered_classifications.dart';

import '../models/mountain_graph.dart';
import '../repositories/mountains_repository.dart';
import '../widgets/drop.dart';
import '../widgets/mountain_height.dart';
import '../widgets/ordered_maps.dart';

class MountainPage extends StatefulWidget {
  final int id;

  const MountainPage({super.key, required this.id});

  @override
  State<MountainPage> createState() => _MountainPageState();
}

class _MountainPageState extends State<MountainPage> {
  MountainGraph? _mountain;

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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            _mountain != null ? _mountain!.name : '',
            style: const TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _mountain != null ? Height(height: _mountain!.height) : null,
        ),
        Expanded(
          child: ListView(
            children: [
              ListTile(
                  title: const Text('Classifications'),
                  subtitle: _mountain != null
                      ? OrderedClassifications(
                          classifications: _mountain!.classifications)
                      : null),
              ListTile(
                title: const Text('Aliases'),
                subtitle: Text(
                    _mountain != null ? _mountain!.aliases.join(', ') : ''),
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
                title: const Text('Region'),
                subtitle: Text(_mountain != null ? _mountain!.region.name : ''),
              ),
              ListTile(
                title: const Text('Countries'),
                subtitle: Text(_mountain != null
                    ? _mountain!.countries.map((x) => x.name).join(', ')
                    : ''),
              ),
              ListTile(
                  title: const Text('Maps'),
                  subtitle: _mountain != null
                      ? OrderedMaps(maps: _mountain!.maps)
                      : null),
              ListTile(
                title: const Text('Summit features'),
                subtitle:
                    Text(_mountain != null ? _mountain!.feature ?? '' : ''),
              ),
              ListTile(
                title: const Text('Summit observations'),
                subtitle: Text(
                    _mountain != null ? _mountain!.observations ?? '' : ''),
              ),
              ListTile(
                  title: const Text('Drop'),
                  subtitle:
                      _mountain != null ? Drop(mountain: _mountain!) : null),
            ],
          ),
        ),
      ],
    );
  }
}
