import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/onboarding_storage.dart';

// Provider to hold the SharedPreferences instance.
// This must be overridden in ProviderScope at the root of the app.
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('sharedPreferencesProvider must be overridden');
});

final onboardingStorageProvider = Provider<OnboardingStorage>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return OnboardingStorage(prefs);
});

final onboardingCompletedProvider =
    NotifierProvider<OnboardingCompletedNotifier, bool>(() {
      return OnboardingCompletedNotifier();
    });

class OnboardingCompletedNotifier extends Notifier<bool> {
  @override
  bool build() {
    final storage = ref.watch(onboardingStorageProvider);
    return storage.hasCompletedOnboarding();
  }

  Future<void> completeOnboarding() async {
    final storage = ref.read(onboardingStorageProvider);
    await storage.completeOnboarding();
    state = true;
  }

  Future<void> resetOnboarding() async {
    final storage = ref.read(onboardingStorageProvider);
    await storage.resetOnboarding();
    state = false;
  }
}
