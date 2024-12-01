// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:news_app_2/Pages/settings_page.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            child: Center(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/icon.png'),
                    radius: 55,
                  ),
                  Text('N E W S'),
                ],
              ),
            ),
          ),
          ListTile(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsPage(),
              ),
            ),
            title: const Text('Settings'),
            trailing: const Icon(Icons.settings),
          ),
          const Divider(),
          ListTile(
            onTap: () async {
              final url = Uri.parse('https://github.com/OracleMatrix');
              if (!await launchUrl(url)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                        Text('Error on launching URL\nPlease try again...'),
                  ),
                );
              }
            },
            title: const Text('About us'),
            trailing: const Icon(
              Icons.info,
              color: Colors.blue,
            ),
          ),
          const Divider(),
          ListTile(
            onTap: () async {
              final url =
                  Uri.parse('https://github.com/OracleMatrix/news_app_2');
              if (!await launchUrl(url)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                        Text('Error on launching URL\nPlease try again...'),
                  ),
                );
              }
            },
            title: const Text('Contribute'),
            trailing: const Icon(
              Icons.handshake_outlined,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
