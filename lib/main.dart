import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghindora/app/app.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:ghindora/features/onboarding/providers/onboarding_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const GhindoraApp(),
    ),
  );
}
