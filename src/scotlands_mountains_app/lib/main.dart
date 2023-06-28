import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:scotlands_mountains_app/widgets/shell.dart';
import 'pages/classifications.dart';
import 'pages/about.dart';
import 'pages/search.dart';
import 'repositories/data.dart';

Future main() async {
  await dotenv.load(fileName: ".local");
  await Data().initialize();

  runApp(const MyApp());
}

final GoRouter _router = GoRouter(initialLocation: '/', routes: <RouteBase>[
  ShellRoute(
    builder: (context, state, child) {
      return Shell(child: child);
    },
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) => '/classifications',
      ),
      GoRoute(
        path: '/classifications',
        builder: (context, state) => const Classifications(),
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) => const Search(),
      ),
      GoRoute(
        path: '/about',
        builder: (context, state) => const About(),
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
    );
  }

  onInitializationComplete() {}
}
