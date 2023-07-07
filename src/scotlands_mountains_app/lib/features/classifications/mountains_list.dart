import 'package:flutter/material.dart';
import '../shared/util.dart';

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
          subtitle: Text(Util.formatHeight(mountains[index].height)),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            Navigator.of(context)
                .pushNamed('/mountains', arguments: mountains[index].id);
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
