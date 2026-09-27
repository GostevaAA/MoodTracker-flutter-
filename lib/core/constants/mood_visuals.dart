import 'package:flutter/material.dart';

import 'mood_level.dart';

/// Единый источник истины для визуализации настроения.
/// Пока использует эмодзи как плейсхолдеры.
/// В будущем: заменить на SVG / иконочный шрифт / Lottie — интерфейс останется тем же.
class MoodVisuals {
  const MoodVisuals._();

  /// Эмодзи-плейсхолдер для каждого уровня настроения.
  static String emojiFor(MoodLevel level) {
    switch (level) {
      case MoodLevel.awful:
        return '😢';
      case MoodLevel.bad:
        return '🙁';
      case MoodLevel.okay:
        return '😐';
      case MoodLevel.good:
        return '🙂';
      case MoodLevel.great:
        return '😄';
    }
  }

  /// Временные цвета для плейсхолдеров.
  /// Позже будут браться из активного пресета темы.
  static Color colorFor(MoodLevel level) {
    switch (level) {
      case MoodLevel.awful:
        return const Color(0xFFE53935); // красный
      case MoodLevel.bad:
        return const Color(0xFFFB8C00); // оранжевый
      case MoodLevel.okay:
        return const Color(0xFFFDD835); // жёлтый
      case MoodLevel.good:
        return const Color(0xFF7CB342); // светло-зелёный
      case MoodLevel.great:
        return const Color(0xFF43A047); // зелёный
    }
  }

  /// Размеры иконок в разных контекстах.
  static const double sizeSmall = 20.0; // календарь
  static const double sizeMedium = 32.0; // список, карточки
  static const double sizeLarge = 64.0; // выбор настроения
}
