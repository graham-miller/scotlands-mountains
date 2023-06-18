import 'package:flutter/material.dart';
import 'package:scotlands_mountains_app/repositories/classifications_repository.dart';
import 'package:scotlands_mountains_app/repositories/mountains_repository.dart';
import '../widgets/sm_app_bar.dart';

class Classifications extends StatefulWidget {
  const Classifications({super.key});

  @override
  State<Classifications> createState() => _ClassificationsState();
}

class _ClassificationsState extends State<Classifications> {
  List<String> _mountains = List.empty();

  _ClassificationsState() {
    _loadMountains();
  }

  void _loadMountains() async {
    final classification = await ClassificationsRepository().getDefault();
    final mountains =
        await MountainsRepository().getByClassificationId(classification.id);

    setState(() {
      _mountains = [mountains[0].name];
    });
  }

  @override
  void initState() {
    super.initState();
    _loadMountains();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SmAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_mountains.any((s) => true)
                ? _mountains[0]
                : 'Classifications'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Increment',
        child: const Icon(Icons.replay_circle_filled),
      ),
    );
  }
}
