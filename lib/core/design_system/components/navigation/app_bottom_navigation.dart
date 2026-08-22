import 'package:flutter/material.dart';

import '../../design_tokens.dart';

class AppBottomNavigationItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const AppBottomNavigationItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

class AppBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<AppBottomNavigationItem> items;

  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor ??
            Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: AppSpacing.bottomNavHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final isSelected = currentIndex == index;
              final item = items[index];

              return Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => onTap(index),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          transitionBuilder: (child, animation) {
                            return ScaleTransition(
                              scale: animation,
                              child: child,
                            );
                          },
                          child: Icon(
                            isSelected ? item.activeIcon : item.icon,
                            key: ValueKey(isSelected),
                            color: isSelected
                                ? AppColors.primary
                                : Theme.of(context).unselectedWidgetColor,
                            size: 24,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.label,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: isSelected
                                ? AppColors.primary
                                : Theme.of(context).unselectedWidgetColor,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
