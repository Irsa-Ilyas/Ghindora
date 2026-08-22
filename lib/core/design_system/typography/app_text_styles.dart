import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String fontFamily =
      'Roboto'; // Default to a standard font for now

  // Display
  static const TextStyle displayLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 57,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.25,
  );
  static const TextStyle displayMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 45,
    fontWeight: FontWeight.bold,
    letterSpacing: 0,
  );
  static const TextStyle displaySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
  );

  // Headings
  static const TextStyle h1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
  );
  static const TextStyle h2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
  );
  static const TextStyle h3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );

  // Titles
  static const TextStyle titleLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );
  static const TextStyle titleMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
  );
  static const TextStyle titleSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );

  // Body
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );
  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  );

  // Labels
  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );
  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );
  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  // Button & Caption
  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  );
}
