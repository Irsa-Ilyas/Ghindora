import 'package:flutter/material.dart';

import '../../design_tokens.dart';
import '../states/app_loader.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final IconData? icon;

  const SecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final bool effectivelyDisabled =
        isDisabled || isLoading || onPressed == null;

    return SizedBox(
      height: AppSpacing.buttonHeight,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: effectivelyDisabled ? null : onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusMd,
          ),
          side: BorderSide(
            color: effectivelyDisabled
                ? Theme.of(context).disabledColor
                : AppColors.primary,
          ),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        ),
        child: isLoading
            ? const AppLoader(size: 24)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20, color: AppColors.primary),
                    const SizedBox(width: AppSpacing.sm),
                  ],
                  Text(
                    text,
                    style: AppTextStyles.button.copyWith(
                      color: effectivelyDisabled
                          ? Theme.of(context).disabledColor
                          : AppColors.primary,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
