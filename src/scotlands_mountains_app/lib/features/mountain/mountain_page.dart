import 'package:flutter/material.dart';

import '../../models/mountain_graph.dart';
import '../../repositories/mountains_repository.dart';
import '../shared/mountain_height.dart';
import 'mountain_details.dart';

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
                child: Height(height: _mountain!.height),
              ),
        _mountain == null
            ? const SizedBox.shrink()
            : MountainDetails(mountain: _mountain!),
      ],
    );
  }
}
