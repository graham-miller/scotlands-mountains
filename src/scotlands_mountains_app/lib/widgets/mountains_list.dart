import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scotlands_mountains_app/widgets/mountain_height.dart';

import '../models/mountain.dart';

class MountainsList extends StatelessWidget {
  final List<Mountain> mountains;

  const MountainsList({super.key, required this.mountains});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: mountains.length,
      itemBuilder: (context, index) {
        return ListTile(
            leading: CircleAvatar(child: Text(((index) + 1).toString())),
            title: Text(mountains[index].name),
            subtitle: Height(height: mountains[index].height),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                context.push('/mountains/${mountains[index].id}');
              },
            ));
      },
    );
  }
}
