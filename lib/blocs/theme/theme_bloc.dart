import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/theme_repository.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc(this._repository) : super(const ThemeState()) {
    on<ThemeStarted>(_onStarted);
    on<ThemePresetChanged>(_onPresetChanged);
    on<ThemeModeChanged>(_onModeChanged);
  }

  final ThemeRepository _repository;

  void _onStarted(ThemeStarted event, Emitter<ThemeState> emit) {
    emit(state.copyWith(
      preset: _repository.getPreset(),
      mode: _repository.getMode(),
      ready: true,
    ));
  }

  Future<void> _onPresetChanged(
    ThemePresetChanged event,
    Emitter<ThemeState> emit,
  ) async {
    await _repository.setPreset(event.preset);
    emit(state.copyWith(preset: event.preset));
  }

  Future<void> _onModeChanged(
    ThemeModeChanged event,
    Emitter<ThemeState> emit,
  ) async {
    await _repository.setMode(event.mode);
    emit(state.copyWith(mode: event.mode));
  }
}
