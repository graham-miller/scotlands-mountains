import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppTheme { light, dark, device }

class ThemeService {
  ThemeService._() {
    PlatformDispatcher.instance.onPlatformBrightnessChanged = () {
      if (appTheme == AppTheme.device) {
        _streamController.add(appTheme);
      }
    };
  }

  static const String _userPreferencesKey = 'app_theme';
  static late SharedPreferences _userPreferences;

  static ThemeService? _instance;
  static Future<ThemeService> get instance async {
    if (_instance == null) {
      _userPreferences = await SharedPreferences.getInstance();
      _instance = ThemeService._();
    }
    return _instance!;
  }

  late final StreamController _streamController = StreamController();

  late final Stream changedStream =
      _streamController.stream.asBroadcastStream();

  AppTheme get appTheme {
    return AppTheme.values.singleWhere((e) =>
        e.toString() ==
        (_userPreferences.getString(_userPreferencesKey) ??
            AppTheme.light.toString()));
  }

  set appTheme(AppTheme appTheme) {
    _userPreferences.setString(_userPreferencesKey, appTheme.toString());
    _streamController.add(null);
  }

  ThemeData get themeData {
    final brightness = appTheme == AppTheme.device
        ? PlatformDispatcher.instance.platformBrightness
        : appTheme == AppTheme.light
            ? Brightness.light
            : Brightness.dark;

    final color = brightness == Brightness.light ? Colors.yellow : Colors.blue;

    return ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: color,
          brightness: brightness,
        ),
        useMaterial3: true);
  }
}
