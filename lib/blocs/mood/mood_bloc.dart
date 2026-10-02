import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker/data/models/mood_entry.dart';

import '../../data/repositories/mood_repository.dart';
import '../../data/repositories/save_result.dart';
import '../../domain/stats/mood_stats.dart';
import 'mood_event.dart';
import 'mood_state.dart';

class MoodBloc extends Bloc<MoodEvent, MoodState> {
  MoodBloc(this._repository) : super(const MoodState()) {
    on<MoodStarted>(_onStarted);
    on<MoodEntryAdded>(_onAdded);
    on<MoodEntryUpdated>(_onUpdated);
    on<MoodEntryDeleted>(_onDeleted);
    on<MoodEntryRestored>(_onRestored);
    on<MoodEntriesImported>(_onImported);
  }

  final MoodRepository _repository;

  Future<void> _onStarted(MoodStarted event, Emitter<MoodState> emit) async {
    emit(state.copyWith(status: MoodStatus.loading));
    await emit.forEach(
      _repository.watchAll(),
      onData: (entries) => state.copyWith(
        status: MoodStatus.ready,
        entries: entries,
        stats: MoodStats.from(entries),
      ),
      onError: (error, _) => state.copyWith(
        status: MoodStatus.failure,
        errorMessage: error.toString(),
      ),
    );
  }

  Future<void> _onAdded(MoodEntryAdded event, Emitter<MoodState> emit) async {
    await _save(event.entry, emit);
  }

  Future<void> _onUpdated(
      MoodEntryUpdated event, Emitter<MoodState> emit) async {
    await _save(event.entry, emit);
  }

  Future<void> _onRestored(
    MoodEntryRestored event,
    Emitter<MoodState> emit,
  ) async {
    try {
      await _repository.saveEntry(event.entry);
    } catch (e) {
      emit(state.copyWith(
        status: MoodStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onDeleted(
      MoodEntryDeleted event, Emitter<MoodState> emit) async {
    try {
      await _repository.deleteById(event.id);
    } catch (e) {
      emit(state.copyWith(
        status: MoodStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  /// Массовый импорт: заменяет все записи на переданные.
  /// Старые данные удаляются — это явно подтверждено пользователем в UI.
  Future<void> _onImported(
    MoodEntriesImported event,
    Emitter<MoodState> emit,
  ) async {
    try {
      await _repository.replaceAll(event.entries);
    } catch (e) {
      emit(state.copyWith(
        status: MoodStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _save(MoodEntry entry, Emitter<MoodState> emit) async {
    try {
      final result = await _repository.saveEntry(entry);
      switch (result) {
        case SaveSuccess():
          break;
        case SaveConflict(:final existing):
          await _repository.replaceEntry(entry, existing);
      }
    } catch (e) {
      emit(state.copyWith(
        status: MoodStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
