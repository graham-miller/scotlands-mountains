import 'package:flutter/material.dart';

import 'features/common/title_logo.dart';
import 'routes.dart';

class Shell extends StatelessWidget {
  final Widget child;

  const Shell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      drawer: _buildDrawer(context),
      body: child,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (context) {
          return Navigator.of(context).canPop()
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                )
              : IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                );
        },
      ),
      title: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home', (route) => false);
        },
        child: const TitleLogo(),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: Routes.currentIndex(context),
      onDestinationSelected: (value) => Routes.navigate(value, context),
      children: [
        const DrawerHeader(
          child: TitleLogo(),
        ),
        ...Routes.navigationDrawerItems,
      ],
    );
  }
}
