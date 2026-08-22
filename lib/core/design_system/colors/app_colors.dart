import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Brand Colors (Premium Indigo)
  static const Color primary = Color(0xFF4F46E5); // Indigo 600
  static const Color primaryContainer = Color(0xFFE0E7FF); // Indigo 100
  static const Color onPrimary = Colors.white;
  static const Color onPrimaryContainer = Color(0xFF312E81); // Indigo 900

  // Secondary Brand Colors (Teal/Mint)
  static const Color secondary = Color(0xFF0D9488); // Teal 600
  static const Color secondaryContainer = Color(0xFFCCFBF1); // Teal 100
  static const Color onSecondary = Colors.white;
  static const Color onSecondaryContainer = Color(0xFF134E4A); // Teal 900

  // Background & Surface - Light
  static const Color backgroundLight = Color(0xFFF9FAFB); // Gray 50
  static const Color surfaceLight = Colors.white;
  static const Color surfaceVariantLight = Color(0xFFF3F4F6); // Gray 100

  // Background & Surface - Dark
  static const Color backgroundDark = Color(0xFF111827); // Gray 900
  static const Color surfaceDark = Color(0xFF1F2937); // Gray 800
  static const Color surfaceVariantDark = Color(0xFF374151); // Gray 700

  // Text Colors - Light
  static const Color textPrimaryLight = Color(0xFF111827); // Gray 900
  static const Color textSecondaryLight = Color(0xFF4B5563); // Gray 600
  static const Color textMutedLight = Color(0xFF9CA3AF); // Gray 400

  // Text Colors - Dark
  static const Color textPrimaryDark = Color(0xFFF9FAFB); // Gray 50
  static const Color textSecondaryDark = Color(0xFFD1D5DB); // Gray 300
  static const Color textMutedDark = Color(0xFF6B7280); // Gray 500

  // Semantic Colors
  static const Color success = Color(0xFF10B981); // Emerald 500
  static const Color warning = Color(0xFFF59E0B); // Amber 500
  static const Color error = Color(0xFFEF4444); // Red 500
  static const Color info = Color(0xFF3B82F6); // Blue 500

  // UI Elements
  static const Color borderLight = Color(0xFFE5E7EB); // Gray 200
  static const Color borderDark = Color(0xFF4B5563); // Gray 600
  static const Color dividerLight = Color(0xFFF3F4F6); // Gray 100
  static const Color dividerDark = Color(0xFF374151); // Gray 700
  static const Color disabledLight = Color(0xFFD1D5DB); // Gray 300
  static const Color disabledDark = Color(0xFF4B5563); // Gray 600
}
