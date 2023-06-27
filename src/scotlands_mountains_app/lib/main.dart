import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'pages/loading.dart';
import 'pages/classifications.dart';
import 'pages/about.dart';
import 'pages/search.dart';

Future main() async {
  await dotenv.load(fileName: ".local");
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
        colorScheme:
            const ColorScheme.light(), //.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      initialRoute: '/loading',
      routes: {
        '/loading': (context) => Loading(
              initializationCompleteCallback: () =>
                  Navigator.popAndPushNamed(context, '/classifications'),
            ),
        //'/lens': (context) => { }
        '/classifications': (context) => const Classifications(),
        '/search': (context) => const Search(),
        //'/favourites': (context) => { }
        //'/settings': (context) => { }
        '/about': (context) => const About(),
      },
    );
  }

  onInitializationComplete() {}
}
