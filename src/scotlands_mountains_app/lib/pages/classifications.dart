import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scotlands_mountains_app/repositories/classifications_repository.dart';
import 'package:scotlands_mountains_app/repositories/mountains_repository.dart';
import 'package:scotlands_mountains_app/widgets/classification_selector.dart';
import '../models/mountain.dart';
import '../widgets/sm_app_bar.dart';

class Classifications extends StatefulWidget {
  const Classifications({super.key});

  @override
  State<Classifications> createState() => _ClassificationsState();
}

class _ClassificationsState extends State<Classifications> {
  List<Mountain> _mountains = List.empty();

  _ClassificationsState() {
    _loadMountains();
  }

  void _loadMountains() async {
    final classification = await ClassificationsRepository().getDefault();
    final mountains =
        await MountainsRepository().getByClassificationId(classification.id);

    setState(() {
      _mountains = mountains;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadMountains();
  }

  @override
  Widget build(BuildContext context) {
    final heightFormat = NumberFormat("#,###", "en_GB");

    return Scaffold(
      appBar: const SmAppBar(),
      body: Column(
        children: [
          const ClassificationSelector(),
          Expanded(
            child: ListView.builder(
              itemCount: _mountains.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(child: Text(((index) + 1).toString())),
                  title: Text(_mountains[index].name),
                  subtitle: Text(
                      '${heightFormat.format(_mountains[index].height)}m (${heightFormat.format(_mountains[index].height * 3.28084)}ft)'),
                  trailing: const Icon(Icons.more_vert),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
