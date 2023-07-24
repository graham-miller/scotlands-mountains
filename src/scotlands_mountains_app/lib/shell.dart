import 'package:flutter/material.dart';

import 'features/common/title_logo.dart';

class Shell extends StatelessWidget {
  final Widget child;

  Shell({super.key, required this.child});

  final List<String> _routes = [
    '/home',
    '/classifications',
    '/search',
    '/weather',
    '/settings',
    '/licenses',
    '/about',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      drawer: _buildDrawer(context),
      body: child,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (context) {
          return Navigator.of(context).canPop()
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                )
              : IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                );
        },
      ),
      title: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home', (route) => false);
        },
        child: const TitleLogo(),
      ),
      actions: const [
        // Builder(
        //   builder: (context) {
        //     return IconButton(
        //       icon: const Icon(Icons.search),
        //       onPressed: () {
        //         Navigator.of(context)
        //             .pushNamedAndRemoveUntil('/search', (route) => false);
        //       },
        //     );
        //   },
        // ),
      ],
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return NavigationDrawer(
      selectedIndex:
          _routes.indexOf(ModalRoute.of(context)?.settings.name ?? _routes[0]),
      onDestinationSelected: (value) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(_routes[value], (route) => false);
      },
      children: const [
        DrawerHeader(
          child: TitleLogo(),
        ),
        NavigationDrawerDestination(
          label: Text('Home'),
          icon: Icon(Icons.home),
        ),
        NavigationDrawerDestination(
          label: Text('Classifications'),
          icon: Icon(Icons.list),
        ),
        NavigationDrawerDestination(
          label: Text('Search'),
          icon: Icon(Icons.search),
        ),
        // const NavigationDrawerDestination(
        //   label: Text('Favourites'),
        //   icon: Icon(Icons.favorite_outline),
        // ),
        NavigationDrawerDestination(
          label: Text('Weather'),
          icon: Icon(Icons.wb_sunny_outlined),
        ),
        Divider(),
        NavigationDrawerDestination(
          label: Text('Settings'),
          icon: Icon(Icons.settings),
        ),
        NavigationDrawerDestination(
          label: Text('Licenses'),
          icon: Icon(Icons.verified_outlined),
        ),
        NavigationDrawerDestination(
          label: Text('About'),
          icon: Icon(Icons.info_outline),
        ),
      ],
    );
  }
}
