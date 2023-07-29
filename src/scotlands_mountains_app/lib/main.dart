import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:scotlands_mountains_app/features/settings/theme_service.dart';
import 'package:scotlands_mountains_app/routes.dart';

import 'repositories/data.dart';

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
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.initialRoute,
          routes: Routes.routingTable,
        );
      },
    );
  }
}
