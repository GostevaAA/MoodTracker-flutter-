import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/mood_repository.dart';
import 'mood_event.dart';
import 'mood_state.dart';

class MoodBloc extends Bloc<MoodEvent, MoodState> {
  MoodBloc(this._repository) : super(const MoodState()) {
    on<MoodStarted>(_onStarted);
    on<MoodEntryAdded>(_onAdded);
    on<MoodEntryUpdated>(_onUpdated);
    on<MoodEntryDeleted>(_onDeleted);
  }

  final MoodRepository _repository;

  Future<void> _onStarted(MoodStarted event, Emitter<MoodState> emit) async {
    emit(state.copyWith(status: MoodStatus.loading));

    // emit.forEach подписывается на стрим и эмитит новое состояние
    // при каждом изменении данных в БД. Пока стрим жив, Bloc жив.
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
    try {
      await _repository.upsert(event.entry);
      // Ничего не эмитим — стрим watchAll сам пришлёт новое состояние
    } catch (e) {
      emit(state.copyWith(
        status: MoodStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onUpdated(
      MoodEntryUpdated event, Emitter<MoodState> emit) async {
    try {
      await _repository.upsert(event.entry);
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
}
