import 'package:flutter/material.dart';

import '../../design_tokens.dart';

class AppTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isDisabled;

  const AppTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isDisabled ? null : onPressed,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
      ),
      child: Text(text, style: AppTextStyles.button),
    );
  }
}
