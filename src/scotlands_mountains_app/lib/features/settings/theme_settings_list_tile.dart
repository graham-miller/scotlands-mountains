import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';

import 'theme_manager.dart';

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

  @override
  void initState() {
    ThemeService.instance.then((value) => setState(
          () {
            _themeService = value;
          },
        ));
    super.initState();
  }

  void _setTheme(
      AppTheme value, ThemeSwitcherState switcher, ThemeData theme) async {
    setState(() {
      _themeService!.appTheme = value;
    });

    switcher.changeTheme(theme: _themeService!.themeData);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Theme'),
      subtitle: _themeService == null
          ? const Center(child: CircularProgressIndicator())
          : ThemeSwitcher.withTheme(
              builder: (_, switcher, theme) {
                return Column(
                  children: [
                    ...AppTheme.values
                        .map((appTheme) => Row(
                              children: [
                                Radio<AppTheme>(
                                  value: appTheme,
                                  groupValue: _themeService!.appTheme,
                                  onChanged: (value) =>
                                      _setTheme(value!, switcher, theme),
                                ),
                                Text(_labels[appTheme]!),
                              ],
                            ))
                        .toList()
                  ],
                );
              },
            ),
    );
  }
}
