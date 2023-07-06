import 'package:flutter/material.dart';

import 'features/shared/title_logo.dart';

class Shell extends StatelessWidget {
  final Widget child;

  Shell({super.key, required this.child});

  final List<String> _routes = [
    '/classifications',
    '/search',
    '/about',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      drawer: _drawer(context),
      body: child,
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (context) {
          return _isSubPage(context)
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
      title: const TitleLogo(),
      actions: [
        Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
      ],
    );
  }

  Widget _drawer(BuildContext context) {
    return NavigationDrawer(
      onDestinationSelected: (value) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(_routes[value], (route) => false);
      },
      children: const [
        DrawerHeader(
          child: TitleLogo(),
        ),
        // const NavigationDrawerDestination(
        //   label: Text('Mountain Lens'),
        //   icon: Icon(Icons.photo),
        // ),
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
        // const Divider(),
        // const NavigationDrawerDestination(
        //   label: Text('Settings'),
        //   icon: Icon(Icons.settings),
        // ),
        Divider(),
        NavigationDrawerDestination(
          label: Text('About'),
          icon: Icon(Icons.info_outline),
        ),
      ],
    );
  }
}
