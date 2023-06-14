import 'package:flutter/material.dart';
import '../widgets/sm_app_bar.dart';

class Classifications extends StatelessWidget {
  const Classifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SmAppBar(),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Classifications'),
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
