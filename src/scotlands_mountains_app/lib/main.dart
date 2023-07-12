import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'features/home/home_page.dart';
import 'features/mountain/mountain_page.dart';
import 'features/weather/weather_page.dart';
import 'features/mountain_list/classifications_page.dart';
import 'features/about/about_page.dart';
import 'features/mountain_list/search_page.dart';
import 'repositories/data.dart';
import 'shell.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  await Data().initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scotland\'s Mountains',
      theme: ThemeData(
        brightness: Brightness.light,
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,
      ),
      // initialRoute: '/home',
      initialRoute: '/classifications',
      routes: {
        '/home': (context) => Shell(child: const HomePage()),
        '/classifications': (context) =>
            Shell(child: const ClassificationsPage()),
        '/mountains': (context) => Shell(
            child: MountainPage(
                id: ModalRoute.of(context)!.settings.arguments as int)),
        '/search': (context) => Shell(child: const SearchPage()),
        '/weather': (context) => Shell(child: const WeatherPage()),
        '/about': (context) => Shell(child: const AboutPage()),
      },
    );
  }

  onInitializationComplete() {}
}
