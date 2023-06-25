import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'menu.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final BottomNavigationBar? bottomNavigationBar;

  const AppScaffold({super.key, required this.body, this.bottomNavigationBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scotland\'s Mountains'),
        //     style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
        // backgroundColor: Theme.of(context).colorScheme.primary,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CircleAvatar(
              child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: SvgPicture.asset(
              'assets/logo.svg',
              colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onPrimary, BlendMode.srcIn),
            ),
          )),
        ),
        actions: [
          Builder(
              builder: (context) => IconButton(
                    icon: const Icon(Icons.menu),
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
