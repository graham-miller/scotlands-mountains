import 'package:flutter/material.dart';

import '../features/settings/theme_settings_list_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ThemeSettingsListTile(),
      ],
    );
  }
}
