import 'dart:async';

import 'package:flutter/material.dart';

import 'theme_service.dart';

class ThemeSettingsListTile extends StatefulWidget {
  const ThemeSettingsListTile({super.key});

  @override
  State<ThemeSettingsListTile> createState() => _ThemeSettingsListTileState();
}

class _ThemeSettingsListTileState extends State<ThemeSettingsListTile> {
  final Map<AppTheme, String> _labels = {
    AppTheme.light: 'Light theme',
    AppTheme.dark: 'Dark theme',
    AppTheme.device: 'Use device settings',
  };

  ThemeService? _themeService;
  StreamSubscription<AppTheme>? _subscription;
  AppTheme? _appTheme;

  @override
  void initState() {
    ThemeService.instance.then((service) {
      setState(() {
        _themeService = service;
        _appTheme = _themeService!.appTheme;
      });
      _subscription = _themeService!.stream.listen((appTheme) {
        setState(() {
          _appTheme = appTheme;
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _setTheme(AppTheme value) async {
    setState(() {
      _themeService!.appTheme = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Theme'),
      subtitle: _themeService == null
          ? const Center(child: CircularProgressIndicator())
          : StreamBuilder<AppTheme>(
              stream: _themeService!.stream,
              builder: (_, __) {
                return Column(
                  children: [
                    ...AppTheme.values.map((appTheme) {
                      return GestureDetector(
                        onTap: () => _setTheme(appTheme),
                        child: Row(
                          children: [
                            Radio<AppTheme>(
                              value: appTheme,
                              groupValue: _appTheme,
                              onChanged: (_) => _setTheme(appTheme),
                            ),
                            Text(_labels[appTheme]!),
                          ],
                        ),
                      );
                    }).toList()
                  ],
                );
              },
            ),
    );
  }
}
