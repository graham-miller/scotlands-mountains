import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../shared/mountain_height.dart';
import '../../models/mountain.dart';

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
          title: getName(mountains[index].name, context),
          subtitle: Height(height: mountains[index].height),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            context.push('/mountains/${mountains[index].id}');
          },
        );
      },
    );
  }

  @protected
  Widget getName(String name, BuildContext context) {
    return Text(name);
  }
}