import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';

enum ThemeSettingOptions { light, dark, device }

class ThemeSettingsListTile extends StatefulWidget {
  const ThemeSettingsListTile({super.key});

  @override
  State<ThemeSettingsListTile> createState() => _ThemeSettingsListTileState();
}

class _ThemeSettingsListTileState extends State<ThemeSettingsListTile> {
  ThemeSettingOptions _themeSetting = ThemeSettingOptions.light;

  void _setTheme(
      ThemeSettingOptions value, ThemeSwitcherState switcher, ThemeData theme) {
    setState(() {
      _themeSetting = value;
    });

    final brightness = _themeSetting == ThemeSettingOptions.device
        ? View.of(context).platformDispatcher.platformBrightness
        : _themeSetting == ThemeSettingOptions.light
            ? Brightness.light
            : Brightness.dark;
    final color = brightness == Brightness.light ? Colors.yellow : Colors.blue;

    switcher.changeTheme(
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
            seedColor: color,
            brightness: brightness,
          ),
          useMaterial3: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Theme'),
      subtitle: ThemeSwitcher.withTheme(
        builder: (_, switcher, theme) {
          return Column(
            children: [
              Row(
                children: [
                  Radio<ThemeSettingOptions>(
                    value: ThemeSettingOptions.light,
                    groupValue: _themeSetting,
                    onChanged: (value) => _setTheme(value!, switcher, theme),
                  ),
                  const Text('Light theme'),
                ],
              ),
              Row(
                children: [
                  Radio<ThemeSettingOptions>(
                    value: ThemeSettingOptions.dark,
                    groupValue: _themeSetting,
                    onChanged: (value) => _setTheme(value!, switcher, theme),
                  ),
                  const Text('Dark theme'),
                ],
              ),
              Row(
                children: [
                  Radio<ThemeSettingOptions>(
                    value: ThemeSettingOptions.device,
                    groupValue: _themeSetting,
                    onChanged: (value) => _setTheme(value!, switcher, theme),
                  ),
                  const Text('Use device settings'),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
