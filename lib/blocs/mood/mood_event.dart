import 'package:equatable/equatable.dart';

import '../../data/models/mood_entry.dart';

abstract class MoodEvent extends Equatable {
  const MoodEvent();

  @override
  List<Object?> get props => [];
}

class MoodStarted extends MoodEvent {
  const MoodStarted();
}

class MoodEntryAdded extends MoodEvent {
  const MoodEntryAdded(this.entry);

  final MoodEntry entry;

  @override
  List<Object?> get props => [entry];
}

class MoodEntryUpdated extends MoodEvent {
  const MoodEntryUpdated(this.entry);

  final MoodEntry entry;

  @override
  List<Object?> get props => [entry];
}

class MoodEntryDeleted extends MoodEvent {
  const MoodEntryDeleted(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

/// Восстановление записи после удаления (undo).
/// Не проверяет конфликты — используется только сразу после удаления.
class MoodEntryRestored extends MoodEvent {
  const MoodEntryRestored(this.entry);

  final MoodEntry entry;

  @override
  List<Object?> get props => [entry];
}
