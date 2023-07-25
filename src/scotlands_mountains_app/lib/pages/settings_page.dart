import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text('Theme'),
          subtitle: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Use dark theme'),
              ThemeSwitcher.withTheme(
                builder: (_, switcher, theme) {
                  return Switch(
                    value: theme.brightness == Brightness.dark,
                    onChanged: (useDark) => switcher.changeTheme(
                      theme: ThemeData.from(
                          colorScheme: ColorScheme.fromSeed(
                            seedColor: theme.brightness == Brightness.light
                                ? Colors.orange
                                : Colors.yellow,
                            brightness: theme.brightness == Brightness.light
                                ? Brightness.dark
                                : Brightness.light,
                          ),
                          useMaterial3: true),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
