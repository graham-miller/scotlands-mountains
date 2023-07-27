import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:scotlands_mountains_app/features/settings/theme_service.dart';
import 'package:scotlands_mountains_app/pages/settings_page.dart';

import 'pages/home_page.dart';
import 'pages/mountain_page.dart';
import 'pages/weather_page.dart';
import 'pages/classifications_page.dart';
import 'pages/about_page.dart';
import 'pages/search_page.dart';
import 'repositories/data.dart';
import 'shell.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  await Data().initialize();

  runApp(ScotlandsMountains(themeService: await ThemeService.instance));
}

class ScotlandsMountains extends StatelessWidget {
  final ThemeService themeService;

  const ScotlandsMountains({required this.themeService, super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: themeService.changedStream,
      builder: (context, snapshot) {
        return MaterialApp(
          title: 'Scotland\'s Mountains',
          theme: themeService.themeData,
          initialRoute: '/home',
          routes: {
            '/home': (context) => Shell(child: const HomePage()),
            '/classifications': (context) =>
                Shell(child: const ClassificationsPage()),
            '/mountains': (context) => Shell(
                child: MountainPage(
                    id: ModalRoute.of(context)!.settings.arguments as int)),
            '/search': (context) => Shell(child: const SearchPage()),
            '/weather': (context) => Shell(child: const WeatherPage()),
            '/settings': (context) => Shell(child: const SettingsPage()),
            '/about': (context) => Shell(child: const AboutPage()),
          },
        );
      },
    );
  }
}
