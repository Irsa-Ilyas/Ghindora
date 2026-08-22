import 'package:flutter/material.dart';

import '../../design_tokens.dart';
import '../buttons/secondary_button.dart';

class AppErrorView extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onRetry;

  const AppErrorView({
    super.key,
    required this.title,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline,
                color: AppColors.error,
                size: 48,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              title,
              style: AppTextStyles.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              style: AppTextStyles.bodyMedium.copyWith(
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.xl),
              SizedBox(
                width: 200,
                child: SecondaryButton(
                  text: 'Try Again',
                  icon: Icons.refresh,
                  onPressed: onRetry,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
