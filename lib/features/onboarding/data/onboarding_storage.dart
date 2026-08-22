import 'package:shared_preferences/shared_preferences.dart';

class OnboardingStorage {
  final SharedPreferences _prefs;
  static const String _onboardingKey = 'hasCompletedOnboarding';

  const OnboardingStorage(this._prefs);

  bool hasCompletedOnboarding() {
    return _prefs.getBool(_onboardingKey) ?? false;
  }

  Future<void> completeOnboarding() async {
    await _prefs.setBool(_onboardingKey, true);
  }

  Future<void> resetOnboarding() async {
    await _prefs.setBool(_onboardingKey, false);
  }
}
