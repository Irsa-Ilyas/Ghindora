import 'package:flutter/material.dart';

import '../../design_tokens.dart';
import '../states/app_loader.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final IconData? icon;

  const PrimaryButton({
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
      child: FilledButton(
        onPressed: effectivelyDisabled ? null : onPressed,
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusMd,
          ),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        ),
        child: isLoading
            ? const AppLoader(size: 24, isWhite: true)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20),
                    const SizedBox(width: AppSpacing.sm),
                  ],
                  Text(text, style: AppTextStyles.button),
                ],
              ),
      ),
    );
  }
}
