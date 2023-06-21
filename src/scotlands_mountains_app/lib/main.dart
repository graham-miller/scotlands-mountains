import 'package:flutter/material.dart';
import './pages/loading.dart';
import './pages/classifications.dart';

void main() {
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
        colorScheme: ColorScheme.light(), //.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      initialRoute: '/loading',
      routes: {
        '/loading': (context) => Loading(
            initializationCompleteCallback: () =>
                Navigator.popAndPushNamed(context, '/classifications')),
        '/classifications': (context) => const Classifications(),
      },
    );
  }

  onInitializationComplete() {}
}
