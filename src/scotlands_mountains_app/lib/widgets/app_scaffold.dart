import 'package:flutter/material.dart';

import 'menu.dart';
import 'title_logo.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final BottomNavigationBar? bottomNavigationBar;

  const AppScaffold({super.key, required this.body, this.bottomNavigationBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleLogo(
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        actions: [
          Builder(
              builder: (context) => IconButton(
                    icon: const Icon(Icons.account_circle),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  )),
        ],
      ),
      drawer: const Menu(),
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
