import 'package:flutter/material.dart';

import '../../design_tokens.dart';

enum AppCardStyle { elevated, outlined, flat }

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final AppCardStyle style;
  final Color? backgroundColor;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.cardPadding),
    this.onTap,
    this.style = AppCardStyle.elevated,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Determine card decoration based on style
    BoxDecoration decoration;

    switch (style) {
      case AppCardStyle.elevated:
        decoration = BoxDecoration(
          color: backgroundColor ?? theme.cardColor,
          borderRadius: AppSpacing.borderRadiusLg,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        );
        break;
      case AppCardStyle.outlined:
        decoration = BoxDecoration(
          color: backgroundColor ?? theme.cardColor,
          borderRadius: AppSpacing.borderRadiusLg,
          border: Border.all(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
          ),
        );
        break;
      case AppCardStyle.flat:
        decoration = BoxDecoration(
          color:
              backgroundColor ??
              theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: AppSpacing.borderRadiusLg,
        );
        break;
    }

    final cardContent = Container(
      decoration: decoration,
      child: ClipRRect(
        borderRadius: AppSpacing.borderRadiusLg,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: AppSpacing.borderRadiusLg,
            child: Padding(padding: padding, child: child),
          ),
        ),
      ),
    );

    return cardContent;
  }
}
