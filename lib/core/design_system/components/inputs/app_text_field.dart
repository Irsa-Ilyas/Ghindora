import 'package:flutter/material.dart';

import '../../design_tokens.dart';

class AppTextField extends StatefulWidget {
  final String label;
  final String? hintText;
  final String? errorText;
  final String? helperText;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool isPassword;
  final bool isDisabled;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final int maxLines;

  const AppTextField({
    super.key,
    required this.label,
    this.hintText,
    this.errorText,
    this.helperText,
    this.obscureText = false,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.isDisabled = false,
    this.onChanged,
    this.validator,
    this.maxLines = 1,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.isPassword || widget.obscureText;
  }

  void _toggleObscure() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label.isNotEmpty) ...[
          Text(
            widget.label,
            style: AppTextStyles.labelLarge.copyWith(
              color: widget.isDisabled
                  ? theme.disabledColor
                  : theme.textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
        ],
        TextFormField(
          controller: widget.controller,
          obscureText: _isObscured,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          enabled: !widget.isDisabled,
          onChanged: widget.onChanged,
          validator: widget.validator,
          maxLines: widget.maxLines,
          style: AppTextStyles.bodyLarge,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: AppTextStyles.bodyLarge.copyWith(color: theme.hintColor),
            errorText: widget.errorText,
            helperText: widget.helperText,
            filled: true,
            fillColor: widget.isDisabled
                ? theme.disabledColor.withValues(alpha: 0.1)
                : theme.colorScheme.surface,
            prefixIcon: widget.prefixIcon != null
                ? Icon(
                    widget.prefixIcon,
                    color: theme.iconTheme.color?.withValues(alpha: 0.7),
                  )
                : null,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _isObscured ? Icons.visibility_off : Icons.visibility,
                      color: theme.iconTheme.color?.withValues(alpha: 0.7),
                    ),
                    onPressed: _toggleObscure,
                  )
                : widget.suffixIcon,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
            border: OutlineInputBorder(
              borderRadius: AppSpacing.borderRadiusMd,
              borderSide: BorderSide(color: theme.colorScheme.outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppSpacing.borderRadiusMd,
              borderSide: BorderSide(
                color: theme.colorScheme.outline.withValues(alpha: 0.5),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppSpacing.borderRadiusMd,
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: AppSpacing.borderRadiusMd,
              borderSide: BorderSide(color: theme.colorScheme.error),
            ),
          ),
        ),
      ],
    );
  }
}
