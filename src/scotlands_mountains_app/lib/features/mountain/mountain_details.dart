import 'package:flutter/material.dart';

import '../../models/mountain_graph.dart';
import 'drop.dart';
import 'ordered_classifications.dart';
import 'ordered_maps.dart';

class MountainDetails extends StatelessWidget {
  final MountainGraph mountain;

  const MountainDetails({super.key, required this.mountain});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
            title: const Text('Classifications'),
            subtitle: OrderedClassifications(
                classifications: mountain.classifications)),
        mountain.aliases.isEmpty
            ? const SizedBox.shrink()
            : ListTile(
                title: const Text('Aliases'),
                subtitle: Text(mountain.aliases.join(', ')),
              ),
        ListTile(
          title: const Text('Latitude, longitude'),
          subtitle: Text('${mountain.latitude}, ${mountain.longitude}'),
        ),
        ListTile(
          title: const Text('Grid ref.'),
          subtitle: Text(mountain.gridRef),
        ),
        ListTile(
          title: const Text('Region'),
          subtitle: Text(mountain.region.name),
        ),
        ListTile(
          title: const Text('Countries'),
          subtitle: Text(mountain.countries.map((x) => x.name).join(', ')),
        ),
        ListTile(
            title: const Text('Maps'),
            subtitle: OrderedMaps(maps: mountain.maps)),
        mountain.feature == null
            ? const SizedBox.shrink()
            : ListTile(
                title: const Text('Summit features'),
                subtitle: Text(mountain.feature ?? ''),
              ),
        mountain.observations == null
            ? const SizedBox.shrink()
            : ListTile(
                title: const Text('Summit observations'),
                subtitle: Text(mountain.observations ?? ''),
              ),
        ListTile(
          title: const Text('Drop'),
          subtitle: Drop(mountain: mountain),
        ),
      ],
    );
  }
}
