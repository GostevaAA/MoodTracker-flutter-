import 'package:flutter/material.dart';

import '../constants/mood_level.dart';
import '../constants/mood_visuals.dart';

/// Универсальная иконка настроения.
/// Сейчас использует Phosphor Icons, позже — кастомные иконки.
/// UI всегда использует этот виджет, а не обращается к пакету напрямую.
class MoodIcon extends StatelessWidget {
  const MoodIcon({
    super.key,
    required this.level,
    this.size = MoodVisuals.sizeMedium,
    this.useMoodColor = true,
  });

  final MoodLevel level;
  final double size;
  final bool useMoodColor;

  @override
  Widget build(BuildContext context) {
    return Icon(
      MoodVisuals.iconFor(level),
      size: size,
      color: useMoodColor
          ? MoodVisuals.colorFor(level)
          : Theme.of(context).colorScheme.onSurface,
    );
  }
}
