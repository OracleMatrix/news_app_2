import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("S E T T I N G S"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Theme'),
            trailing: Switch(
              value: AdaptiveTheme.of(context).mode.isDark,
              onChanged: (value) {
                AdaptiveTheme.of(context).setThemeMode(
                    value ? AdaptiveThemeMode.dark : AdaptiveThemeMode.light);
              },
            ),
          )
        ],
      ),
    );
  }
}
