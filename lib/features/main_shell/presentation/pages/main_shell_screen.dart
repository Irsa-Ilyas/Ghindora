import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design_system/components/navigation/app_bottom_navigation.dart';

class MainShellScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShellScreen({super.key, required this.navigationShell});

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      // Support navigating to the initial location when tapping the item that is already active.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: navigationShell.currentIndex,
        onTap: _onTap,
        items: const [
          AppBottomNavigationItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: 'Home',
          ),
          AppBottomNavigationItem(
            icon: Icons.search_outlined,
            activeIcon: Icons.search,
            label: 'Search',
          ),
          AppBottomNavigationItem(
            icon: Icons.location_on_outlined,
            activeIcon: Icons.location_on,
            label: 'Locations',
          ),
          AppBottomNavigationItem(
            icon: Icons.favorite_outline,
            activeIcon: Icons.favorite,
            label: 'Favorites',
          ),
          AppBottomNavigationItem(
            icon: Icons.settings_outlined,
            activeIcon: Icons.settings,
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
