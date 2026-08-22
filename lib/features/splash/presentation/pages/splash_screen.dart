import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ghindora/app/router/route_names.dart';
import 'package:ghindora/core/design_system/design_tokens.dart';
import 'package:ghindora/features/onboarding/providers/onboarding_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    // Simulate initialization delay
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      final hasCompletedOnboarding = ref.read(onboardingCompletedProvider);

      if (hasCompletedOnboarding) {
        context.go(RouteNames.home);
      } else {
        context.go(RouteNames.onboarding);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Placeholder
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.storefront,
                  size: 64,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Ghindora',
                style: AppTextStyles.displaySmall.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
