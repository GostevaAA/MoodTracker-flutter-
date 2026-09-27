import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../core/theme/theme_preset.dart';

class ThemeState extends Equatable {
  const ThemeState({
    this.preset = ThemePresetId.claren,
    this.mode = ThemeMode.system,
    this.ready = false,
  });

  final ThemePresetId preset;
  final ThemeMode mode;
  final bool ready;

  ThemeState copyWith({
    ThemePresetId? preset,
    ThemeMode? mode,
    bool? ready,
  }) {
    return ThemeState(
      preset: preset ?? this.preset,
      mode: mode ?? this.mode,
      ready: ready ?? this.ready,
    );
  }

  @override
  List<Object?> get props => [preset, mode, ready];
}
