import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppTheme { light, dark, device }

class ThemeService {
  ThemeService._();
  static late SharedPreferences _userPreferences;
  static ThemeService? _instance;

  static const String _userPreferencesKey = 'app_theme';

  static Future<ThemeService> get instance async {
    if (_instance == null) {
      _userPreferences = await SharedPreferences.getInstance();
      _instance = ThemeService._();
    }
    return _instance!;
  }

  AppTheme get appTheme {
    return AppTheme.values.singleWhere((e) =>
        e.toString() ==
        (_userPreferences.getString(_userPreferencesKey) ??
            AppTheme.light.toString()));
  }

  set appTheme(AppTheme appTheme) {
    _userPreferences.setString(_userPreferencesKey, appTheme.toString());
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
