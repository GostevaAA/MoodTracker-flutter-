import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker/data/models/mood_entry.dart';

import '../../data/repositories/mood_repository.dart';
import '../../data/repositories/save_result.dart';
import 'mood_event.dart';
import 'mood_state.dart';

class MoodBloc extends Bloc<MoodEvent, MoodState> {
  MoodBloc(this._repository) : super(const MoodState()) {
    on<MoodStarted>(_onStarted);
    on<MoodEntryAdded>(_onAdded);
    on<MoodEntryUpdated>(_onUpdated);
    on<MoodEntryDeleted>(_onDeleted);
    on<MoodEntryRestored>(_onRestored);
  }

  final MoodRepository _repository;

  Future<void> _onStarted(MoodStarted event, Emitter<MoodState> emit) async {
    emit(state.copyWith(status: MoodStatus.loading));
    await emit.forEach(
      _repository.watchAll(),
      onData: (entries) => state.copyWith(
        status: MoodStatus.ready,
        entries: entries,
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
    // Восстановление после удаления — всегда безопасно,
    // потому что запись только что удалили с этой же даты.
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

  /// Общая логика сохранения.
  ///
  /// Редактор уже проверил конфликт и, если был, разрешил его
  /// через `replaceEntry` до отправки события в Bloc.
  /// Поэтому здесь конфликт маловероятен, но на всякий случай
  /// обрабатываем его заменой — пользователь уже дал согласие.
  Future<void> _save(MoodEntry entry, Emitter<MoodState> emit) async {
    try {
      final result = await _repository.saveEntry(entry);
      switch (result) {
        case SaveSuccess():
          // стрим watchAll сам пришлёт новое состояние
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
