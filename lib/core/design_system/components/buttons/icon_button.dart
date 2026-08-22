import 'package:flutter/material.dart';

import '../../design_tokens.dart';

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final bool isDisabled;
  final Color? color;
  final double size;

  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.isDisabled = false,
    this.color,
    this.size = AppSpacing.iconMd,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: isDisabled ? null : onPressed,
      icon: Icon(
        icon,
        size: size,
        color: isDisabled
            ? Theme.of(context).disabledColor
            : (color ?? AppColors.primary),
      ),
      padding: const EdgeInsets.all(AppSpacing.sm),
      splashRadius: AppSpacing.iconMd * 1.2,
    );
  }
}
