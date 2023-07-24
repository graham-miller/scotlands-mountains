import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ThemeSwitcher.withTheme(
          builder: (_, switcher, theme) {
            return IconButton(
              onPressed: () => switcher.changeTheme(
                theme: ThemeData.from(
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: theme.brightness == Brightness.light
                          ? Colors.blue
                          : Colors.yellow,
                      brightness: theme.brightness == Brightness.light
                          ? Brightness.dark
                          : Brightness.light,
                    ),
                    useMaterial3: true),
              ),
              icon: const Icon(Icons.brightness_3, size: 25),
            );
          },
        ),
      ],
    );
  }
}
