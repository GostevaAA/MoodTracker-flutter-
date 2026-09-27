import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../core/theme/theme_preset.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

/// Запуск Bloc-а — читаем сохранённые настройки.
class ThemeStarted extends ThemeEvent {
  const ThemeStarted();
}

/// Смена активного пресета.
class ThemePresetChanged extends ThemeEvent {
  const ThemePresetChanged(this.preset);

  final ThemePresetId preset;

  @override
  List<Object?> get props => [preset];
}

/// Смена режима яркости (light / dark / system).
class ThemeModeChanged extends ThemeEvent {
  const ThemeModeChanged(this.mode);

  final ThemeMode mode;

  @override
  List<Object?> get props => [mode];
}
