import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:scotlands_mountains_app/features/settings/theme_manager.dart';
import 'package:scotlands_mountains_app/pages/settings_page.dart';

import 'pages/licenses_page.dart';
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

  final themeService = await ThemeService.instance;

  runApp(MyApp(theme: themeService.themeData));
}

class MyApp extends StatelessWidget {
  final ThemeData theme;

  const MyApp({required this.theme, super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: theme,
      builder: (context, theme) {
        return MaterialApp(
          title: 'Scotland\'s Mountains',
          theme: theme,
          // initialRoute: '/home',
          initialRoute: '/settings',
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
            '/licenses': (context) => Shell(child: const LicensesPage()),
            '/about': (context) => Shell(child: const AboutPage()),
          },
        );
      },
    );
  }
}
