import 'package:flutter/material.dart';

import '../constants/mood_level.dart';
import '../constants/mood_visuals.dart';

/// Универсальная иконка настроения.
/// Сейчас рисует эмодзи, позже — кастомную иконку.
/// UI всегда использует этот виджет, а не напрямую эмодзи/SVG.
class MoodIcon extends StatelessWidget {
  const MoodIcon({
    super.key,
    required this.level,
    this.size = MoodVisuals.sizeMedium,
  });

  final MoodLevel level;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      MoodVisuals.emojiFor(level),
      style: TextStyle(fontSize: size),
    );
  }
}
