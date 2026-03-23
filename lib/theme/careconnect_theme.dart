import 'package:flutter/material.dart';

class CareConnectColors {
  static const Color background = Color(0xFFF4F7FB);
  static const Color surface = Colors.white;
  static const Color surfaceSoft = Color(0xFFEFF4F7);
  static const Color teal = Color(0xFF33B29E);
  static const Color tealDark = Color(0xFF1EA08E);
  static const Color tealLight = Color(0xFFDAF3EF);
  static const Color textPrimary = Color(0xFF16232F);
  static const Color textSecondary = Color(0xFF6F7B85);
  static const Color border = Color(0xFFE4EAF0);
  static const Color success = Color(0xFF28B96E);
  static const Color warning = Color(0xFFF1B12B);
  static const Color danger = Color(0xFFE15554);
  static const Color mutedChip = Color(0xFFF0F6F4);
}

ThemeData buildLightTheme() {
  final base = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: CareConnectColors.teal,
      brightness: Brightness.light,
      surface: CareConnectColors.surface,
    ),
    useMaterial3: true,
  );

  return base.copyWith(
    scaffoldBackgroundColor: CareConnectColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: CareConnectColors.textPrimary),
      titleTextStyle: TextStyle(
        color: CareConnectColors.textPrimary,
        fontSize: 26,
        fontWeight: FontWeight.w800,
      ),
    ),
    cardTheme: CardTheme(
      color: CareConnectColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      hintStyle: const TextStyle(color: CareConnectColors.textSecondary),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: CareConnectColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: CareConnectColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: CareConnectColors.teal, width: 1.4),
      ),
    ),
    textTheme: base.textTheme.apply(
      bodyColor: CareConnectColors.textPrimary,
      displayColor: CareConnectColors.textPrimary,
    ),
    iconTheme: const IconThemeData(color: CareConnectColors.textPrimary),
  );
}

ThemeData buildDarkTheme() {
  return buildLightTheme().copyWith(
    scaffoldBackgroundColor: const Color(0xFF0F1722),
    cardTheme: CardTheme(
      color: const Color(0xFF172331),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: CareConnectColors.teal,
      brightness: Brightness.dark,
      surface: const Color(0xFF172331),
    ),
  );
}
