import 'package:flutter/material.dart';

import '../../design_tokens.dart';
import '../buttons/primary_button.dart';
import '../buttons/secondary_button.dart';

class AppEmptyView extends StatelessWidget {
  final String title;
  final String description;
  final IconData? icon;
  final String? actionText;
  final VoidCallback? onActionTap;
  final bool useSecondaryButton;

  const AppEmptyView({
    super.key,
    required this.title,
    required this.description,
    this.icon,
    this.actionText,
    this.onActionTap,
    this.useSecondaryButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 64,
                color: Theme.of(context).disabledColor.withValues(alpha: 0.5),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
            Text(
              title,
              style: AppTextStyles.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              description,
              style: AppTextStyles.bodyMedium.copyWith(
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
              textAlign: TextAlign.center,
            ),
            if (actionText != null && onActionTap != null) ...[
              const SizedBox(height: AppSpacing.lg),
              SizedBox(
                width: 200,
                child: useSecondaryButton
                    ? SecondaryButton(text: actionText!, onPressed: onActionTap)
                    : PrimaryButton(text: actionText!, onPressed: onActionTap),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
