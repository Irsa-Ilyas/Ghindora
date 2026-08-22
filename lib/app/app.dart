import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghindora/app/router/app_router.dart';
import 'package:ghindora/app/theme/app_theme.dart';
import 'package:ghindora/app/theme/theme_provider.dart';
import 'package:ghindora/core/constants/app_constants.dart';

class GhindoraApp extends ConsumerWidget {
  const GhindoraApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: appRouter,
    );
  }
}
