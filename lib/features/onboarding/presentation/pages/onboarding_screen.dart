import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../core/design_system/design_tokens.dart';
import '../../../../core/design_system/components/buttons/primary_button.dart';
import '../../../../core/design_system/components/buttons/text_button.dart';
import '../../providers/onboarding_provider.dart';

class OnboardingPageData {
  final String title;
  final String description;
  final IconData icon;

  const OnboardingPageData({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPageData> _pages = const [
    OnboardingPageData(
      title: 'Lose Things Often?',
      description: 'Stop wasting time searching. We help you remember where you put your most important items.',
      icon: Icons.search_off_outlined,
    ),
    OnboardingPageData(
      title: 'How It Works',
      description: 'Simply add an item, assign a location in your space, and always know where to find it later.',
      icon: Icons.auto_awesome_outlined,
    ),
    OnboardingPageData(
      title: 'Your Data, Your Control',
      description: 'Your privacy matters. We only ask for the permissions we truly need to run the app properly.',
      icon: Icons.shield_outlined,
    ),
    OnboardingPageData(
      title: 'Ready to organize?',
      description: 'Add your first item now to see how easy it is to keep track of everything.',
      icon: Icons.inventory_2_outlined,
    ),
  ];

  void _onNext() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      _onFinishAndAdd();
    }
  }

  void _onFinishAndAdd() {
    ref.read(onboardingCompletedProvider.notifier).completeOnboarding();
    context.go(RouteNames.addItem);
  }

  void _onSkip() {
    ref.read(onboardingCompletedProvider.notifier).completeOnboarding();
    context.go(RouteNames.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip Button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: AppTextButton(text: 'Skip', onPressed: _onSkip),
              ),
            ),

            // PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xl,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(AppSpacing.xxl),
                          decoration: BoxDecoration(
                            color: AppColors.primaryContainer,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            page.icon,
                            size: 80,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xxl),
                        Text(
                          page.title,
                          style: AppTextStyles.h2,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          page.description,
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Bottom Controls
            Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                children: [
                  // Page Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: _currentPage == index ? 24 : 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? AppColors.primary
                              : Theme.of(context).disabledColor
                                    .withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // Next / Get Started Button
                  PrimaryButton(
                    text: _currentPage == _pages.length - 1
                        ? 'Add Your First Item'
                        : 'Continue',
                    onPressed: _onNext,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
