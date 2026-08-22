import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ghindora/app/router/route_names.dart';
import 'package:ghindora/features/splash/presentation/pages/splash_screen.dart';
import 'package:ghindora/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:ghindora/features/main_shell/presentation/pages/main_shell_screen.dart';
import 'package:ghindora/features/home/presentation/pages/home_screen.dart';
import 'package:ghindora/features/search/presentation/pages/search_screen.dart';
import 'package:ghindora/features/locations/presentation/pages/locations_screen.dart';
import 'package:ghindora/features/favorites/presentation/pages/favorites_screen.dart';
import 'package:ghindora/features/settings/presentation/pages/settings_screen.dart';
import 'package:ghindora/features/design_showcase/presentation/pages/design_preview_screen.dart';
import 'package:ghindora/features/items/presentation/pages/add_item_page.dart';
import 'package:ghindora/features/items/presentation/pages/item_detail_page.dart';
import 'package:ghindora/features/items/presentation/pages/edit_item_page.dart';
import 'package:ghindora/features/items/presentation/pages/item_history_page.dart';
import 'package:ghindora/features/items/presentation/pages/archived_items_page.dart';
import 'package:ghindora/core/design_system/components/states/app_error_view.dart';
import 'package:ghindora/core/widgets/app_scaffold.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> _shellNavigatorHome = GlobalKey<NavigatorState>(
  debugLabel: 'shellHome',
);
final GlobalKey<NavigatorState> _shellNavigatorSearch =
    GlobalKey<NavigatorState>(debugLabel: 'shellSearch');
final GlobalKey<NavigatorState> _shellNavigatorLocations =
    GlobalKey<NavigatorState>(debugLabel: 'shellLocations');
final GlobalKey<NavigatorState> _shellNavigatorFavorites =
    GlobalKey<NavigatorState>(debugLabel: 'shellFavorites');
final GlobalKey<NavigatorState> _shellNavigatorSettings =
    GlobalKey<NavigatorState>(debugLabel: 'shellSettings');

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: RouteNames.splash,
  routes: [
    GoRoute(
      path: RouteNames.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: RouteNames.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShellScreen(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHome,
          routes: [
            GoRoute(
              path: RouteNames.home,
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorSearch,
          routes: [
            GoRoute(
              path: RouteNames.search,
              builder: (context, state) => const SearchScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorLocations,
          routes: [
            GoRoute(
              path: RouteNames.locations,
              builder: (context, state) => const LocationsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorFavorites,
          routes: [
            GoRoute(
              path: RouteNames.favorites,
              builder: (context, state) => const FavoritesScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorSettings,
          routes: [
            GoRoute(
              path: RouteNames.settings,
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: RouteNames.addItem,
      builder: (context, state) => const AddItemPage(),
    ),
    GoRoute(
      path: RouteNames.archivedItems,
      builder: (context, state) => const ArchivedItemsPage(),
    ),
    GoRoute(
      path: RouteNames.itemDetail,
      builder: (context, state) {
        final itemId = state.pathParameters['itemId'] ?? '';
        return ItemDetailPage(itemId: itemId);
      },
    ),
    GoRoute(
      path: RouteNames.editItem,
      builder: (context, state) {
        final itemId = state.pathParameters['itemId'] ?? '';
        return EditItemPage(itemId: itemId);
      },
    ),
    GoRoute(
      path: RouteNames.itemHistory,
      builder: (context, state) {
        final itemId = state.pathParameters['itemId'] ?? '';
        return ItemHistoryPage(itemId: itemId);
      },
    ),
    GoRoute(
      path: RouteNames.designPreview,
      builder: (context, state) => const DesignPreviewScreen(),
    ),
  ],
  errorBuilder: (context, state) => AppScaffold(
    title: 'Not Found',
    body: AppErrorView(
      title: 'Page Not Found',
      message: 'Route not found: ${state.uri.path}',
      onRetry: () => context.go(RouteNames.home),
    ),
  ),
);
