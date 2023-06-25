import 'package:flutter/material.dart';

import 'title_logo.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: TitleLogo(color: Theme.of(context).colorScheme.onPrimary),
          ),
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text('Mountain Lens'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Classifications'),
            onTap: () {
              Navigator.pop(context);
              Navigator.popAndPushNamed(context, '/classifications');
            },
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Search'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite_outline),
            title: const Text('Favourites'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context);
              Navigator.popAndPushNamed(context, '/about');
            },
          ),
        ],
      ),
    );
  }
}
