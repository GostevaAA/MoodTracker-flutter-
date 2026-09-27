import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'theme.dart';
import 'theme_fiore.dart';
import 'theme_preset.dart';

/// Обёртка над сгенерированными Material Theme Builder темами.
class AppTheme {
  const AppTheme._();

  /// Базовый TextTheme на основе Google Fonts.
  static TextTheme _textTheme() {
    final base = GoogleFonts.robotoTextTheme();
    final display = GoogleFonts.robotoSerifTextTheme();

    return base.copyWith(
      displayLarge: display.displayLarge,
      displayMedium: display.displayMedium,
      displaySmall: display.displaySmall,
      headlineLarge: display.headlineLarge,
      headlineMedium: display.headlineMedium,
      headlineSmall: display.headlineSmall,
      titleLarge: display.titleLarge,
    );
  }

  /// Светлая тема для указанного пресета.
  static ThemeData light(ThemePresetId preset) {
    final textTheme = _textTheme();
    switch (preset) {
      case ThemePresetId.claren:
        return MaterialTheme(textTheme).light();
      case ThemePresetId.fiore:
        return MaterialThemeFiore(textTheme).light();
    }
  }

  /// Тёмная тема для указанного пресета.
  static ThemeData dark(ThemePresetId preset) {
    final textTheme = _textTheme();
    switch (preset) {
      case ThemePresetId.claren:
        return MaterialTheme(textTheme).dark();
      case ThemePresetId.fiore:
        return MaterialThemeFiore(textTheme).dark();
    }
  }
}
