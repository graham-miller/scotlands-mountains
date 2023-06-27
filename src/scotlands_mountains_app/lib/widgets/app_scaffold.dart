import 'package:flutter/material.dart';

import 'title_logo.dart';

enum AppRoutes { classifications, search, about }

class AppScaffold extends StatelessWidget {
  final Widget body;
  final AppRoutes activeRoute;
  final BottomNavigationBar? bottomNavigationBar;

  const AppScaffold(
      {super.key,
      required this.body,
      required this.activeRoute,
      this.bottomNavigationBar});

  _navigate(BuildContext context, AppRoutes selectedRoute) {
    Navigator.pop(context);
    switch (selectedRoute) {
      case AppRoutes.classifications:
        Navigator.popAndPushNamed(context, '/classifications');
        break;
      case AppRoutes.search:
        Navigator.popAndPushNamed(context, '/search');
        break;
      case AppRoutes.about:
        Navigator.popAndPushNamed(context, '/about');
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      drawer: _drawer(context),
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
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
    );
  }

  Widget _drawer(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: AppRoutes.values.indexOf(activeRoute),
      onDestinationSelected: (value) =>
          _navigate(context, AppRoutes.values[value]),
      children: [
        DrawerHeader(
          child: TitleLogo(color: Theme.of(context).colorScheme.onBackground),
        ),
        // const NavigationDrawerDestination(
        //   label: Text('Mountain Lens'),
        //   icon: Icon(Icons.photo),
        // ),
        const NavigationDrawerDestination(
          label: Text('Classifications'),
          icon: Icon(Icons.list),
        ),
        const NavigationDrawerDestination(
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
        const Divider(),
        const NavigationDrawerDestination(
          label: Text('About'),
          icon: Icon(Icons.info_outline),
        ),
      ],
    );
  }
}
