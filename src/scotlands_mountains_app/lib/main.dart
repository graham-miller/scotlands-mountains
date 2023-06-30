import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';

import 'pages/shell.dart';
import 'pages/classifications_page.dart';
import 'pages/about_page.dart';
import 'pages/mountain_page.dart';
import 'pages/search_page.dart';
import 'repositories/data.dart';

Future main() async {
  await dotenv.load(fileName: ".local");
  await Data().initialize();

  runApp(const MyApp());
}

final GoRouter _router = GoRouter(initialLocation: '/classifications', routes: [
  ShellRoute(
    builder: (context, state, child) {
      return Shell(child: child);
    },
    routes: [
      GoRoute(
        path: '/classifications',
        builder: (context, state) => const ClassificationsPage(),
      ),
      GoRoute(
        path: '/mountains/:id',
        builder: (context, state) =>
            MountainPage(id: int.parse(state.pathParameters['id']!)),
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) => const SearchPage(),
      ),
      GoRoute(
        path: '/about',
        builder: (context, state) => const AboutPage(),
      ),
    ],
  ),
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Scotland\'s Mountains',
      theme: ThemeData(
        brightness: Brightness.light,
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,
      ),
    );
  }

  onInitializationComplete() {}
}
