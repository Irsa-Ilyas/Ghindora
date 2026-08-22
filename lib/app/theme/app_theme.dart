import 'package:flutter/material.dart';

import '../../core/design_system/design_tokens.dart';

class AppTheme {
  static TextTheme _buildTextTheme(Color color) {
    return TextTheme(
      displayLarge: AppTextStyles.displayLarge.copyWith(color: color),
      displayMedium: AppTextStyles.displayMedium.copyWith(color: color),
      displaySmall: AppTextStyles.displaySmall.copyWith(color: color),
      headlineLarge: AppTextStyles.h1.copyWith(color: color),
      headlineMedium: AppTextStyles.h2.copyWith(color: color),
      headlineSmall: AppTextStyles.h3.copyWith(color: color),
      titleLarge: AppTextStyles.titleLarge.copyWith(color: color),
      titleMedium: AppTextStyles.titleMedium.copyWith(color: color),
      titleSmall: AppTextStyles.titleSmall.copyWith(color: color),
      bodyLarge: AppTextStyles.bodyLarge.copyWith(color: color),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(color: color),
      bodySmall: AppTextStyles.bodySmall.copyWith(color: color),
      labelLarge: AppTextStyles.labelLarge.copyWith(color: color),
      labelMedium: AppTextStyles.labelMedium.copyWith(color: color),
      labelSmall: AppTextStyles.labelSmall.copyWith(color: color),
    );
  }

  static ThemeData get lightTheme {
    final colorScheme = const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.primaryContainer,
      onPrimaryContainer: AppColors.onPrimaryContainer,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      secondaryContainer: AppColors.secondaryContainer,
      onSecondaryContainer: AppColors.onSecondaryContainer,
      error: AppColors.error,
      onError: Colors.white,
      surface: AppColors.surfaceLight,
      onSurface: AppColors.textPrimaryLight,
      surfaceContainerHighest: AppColors.surfaceVariantLight,
      outline: AppColors.borderLight,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      cardColor: AppColors.surfaceLight,
      disabledColor: AppColors.disabledLight,
      dividerColor: AppColors.dividerLight,
      hintColor: AppColors.textMutedLight,
      unselectedWidgetColor: AppColors.textMutedLight,
      textTheme: _buildTextTheme(AppColors.textPrimaryLight),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surfaceLight,
        foregroundColor: AppColors.textPrimaryLight,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }

  static ThemeData get darkTheme {
    final colorScheme = const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.primaryContainer,
      onPrimaryContainer: AppColors.onPrimaryContainer,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      secondaryContainer: AppColors.secondaryContainer,
      onSecondaryContainer: AppColors.onSecondaryContainer,
      error: AppColors.error,
      onError: Colors.black,
      surface: AppColors.surfaceDark,
      onSurface: AppColors.textPrimaryDark,
      surfaceContainerHighest: AppColors.surfaceVariantDark,
      outline: AppColors.borderDark,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      cardColor: AppColors.surfaceDark,
      disabledColor: AppColors.disabledDark,
      dividerColor: AppColors.dividerDark,
      hintColor: AppColors.textMutedDark,
      unselectedWidgetColor: AppColors.textMutedDark,
      textTheme: _buildTextTheme(AppColors.textPrimaryDark),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surfaceDark,
        foregroundColor: AppColors.textPrimaryDark,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}
