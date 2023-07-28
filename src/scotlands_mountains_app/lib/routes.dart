import 'dart:collection';

import 'package:flutter/material.dart';

import 'pages/about_page.dart';
import 'pages/classifications_page.dart';
import 'pages/compass_page.dart';
import 'pages/home_page.dart';
import 'pages/search_page.dart';
import 'pages/settings_page.dart';
import 'pages/weather_page.dart';
import 'shell.dart';

class Route {
  final String path;
  final String displayName;
  final IconData icon;
  final Widget Function(BuildContext context) navigate;
  final bool dividerBefore;

  Route(
      {required this.path,
      required this.displayName,
      required this.icon,
      required this.navigate,
      this.dividerBefore = false});
}

class Routes {
  static const initialRoute = '/home';

  static final List<Route> all = List.from([
    Route(
      path: '/home',
      displayName: 'Home',
      icon: Icons.home,
      navigate: (context) => const Shell(child: HomePage()),
    ),
    Route(
      path: '/classifications',
      displayName: 'Classifications',
      icon: Icons.list,
      navigate: (context) => const Shell(child: ClassificationsPage()),
    ),
    Route(
      path: '/search',
      displayName: 'Search',
      icon: Icons.search,
      navigate: (context) => const Shell(child: SearchPage()),
    ),
    Route(
      path: '/weather',
      displayName: 'Weather',
      icon: Icons.wb_sunny_outlined,
      navigate: (context) => const Shell(child: WeatherPage()),
    ),
    Route(
      path: '/compasss',
      displayName: 'Compass',
      icon: Icons.explore_outlined,
      navigate: (context) => const Shell(child: CompassPage()),
    ),
    Route(
      path: '/settings',
      displayName: 'Settings',
      icon: Icons.settings,
      navigate: (context) => const Shell(child: SettingsPage()),
      dividerBefore: true,
    ),
    Route(
      path: '/about',
      displayName: 'About',
      icon: Icons.info_outline,
      navigate: (context) => const Shell(child: AboutPage()),
    ),
  ]);

  static int currentIndex(BuildContext context) {
    return Routes.all
        .map((r) => r.path)
        .toList()
        .indexOf(ModalRoute.of(context)?.settings.name ?? Routes.all[0].path);
  }

  static void navigate(int routeIndex, BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Routes.all[routeIndex].path, (route) => false);
  }

  static Map<String, Widget Function(BuildContext)> get routingTable {
    return HashMap.fromIterable(all,
        key: (r) => r.path, value: (r) => r.navigate);
  }

  static List<Widget> get navigationDrawerItems {
    final list = List<Widget>.empty(growable: true);

    for (var route in all) {
      if (route.dividerBefore) {
        list.add(const Divider());
      }

      list.add(NavigationDrawerDestination(
        label: Text(route.displayName),
        icon: Icon(route.icon),
      ));
    }

    return list;
  }
}
