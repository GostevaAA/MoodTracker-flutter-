import 'package:equatable/equatable.dart';

import '../../data/models/mood_entry.dart';

abstract class MoodEvent extends Equatable {
  const MoodEvent();

  @override
  List<Object?> get props => [];
}

/// Запуск Bloc-а: подписаться на стрим записей из БД.
class MoodStarted extends MoodEvent {
  const MoodStarted();
}

/// Добавить новую запись.
class MoodEntryAdded extends MoodEvent {
  const MoodEntryAdded(this.entry);

  final MoodEntry entry;

  @override
  List<Object?> get props => [entry];
}

/// Обновить существующую запись.
class MoodEntryUpdated extends MoodEvent {
  const MoodEntryUpdated(this.entry);

  final MoodEntry entry;

  @override
  List<Object?> get props => [entry];
}

/// Удалить запись по id.
class MoodEntryDeleted extends MoodEvent {
  const MoodEntryDeleted(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}
