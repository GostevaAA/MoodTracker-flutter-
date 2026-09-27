import 'package:equatable/equatable.dart';

import '../../data/models/mood_entry.dart';

enum MoodStatus { initial, loading, ready, failure }

class MoodState extends Equatable {
  const MoodState({
    this.status = MoodStatus.initial,
    this.entries = const [],
    this.errorMessage,
  });

  final MoodStatus status;
  final List<MoodEntry> entries;
  final String? errorMessage;

  MoodState copyWith({
    MoodStatus? status,
    List<MoodEntry>? entries,
    String? errorMessage,
  }) {
    return MoodState(
      status: status ?? this.status,
      entries: entries ?? this.entries,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, entries, errorMessage];
}
