import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import 'mood_level.dart';

/// Единый источник истины для визуализации настроения.
/// Сейчас использует иконки Phosphor как плейсхолдер.
/// Позже можно заменить на SVG / иконочный шрифт / Lottie —
/// интерфейс (методы этого класса) останется тем же.
class MoodVisuals {
  const MoodVisuals._();

  /// Иконка для каждого уровня настроения.
  static IconData iconFor(MoodLevel level) {
    switch (level) {
      case MoodLevel.awful:
        return PhosphorIconsFill.smileyXEyes;
      case MoodLevel.bad:
        return PhosphorIconsFill.smileySad;
      case MoodLevel.okay:
        return PhosphorIconsFill.smileyMeh;
      case MoodLevel.good:
        return PhosphorIconsFill.smiley;
      case MoodLevel.great:
        return PhosphorIconsFill.smileyWink;
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
