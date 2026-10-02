import 'package:equatable/equatable.dart';

import '../../data/models/mood_entry.dart';
import '../../domain/stats/mood_stats.dart';

enum MoodStatus { initial, loading, ready, failure }

class MoodState extends Equatable {
  const MoodState({
    this.status = MoodStatus.initial,
    this.entries = const [],
    this.stats = MoodStats.empty,
    this.errorMessage,
  });

  final MoodStatus status;
  final List<MoodEntry> entries;
  final MoodStats stats;
  final String? errorMessage;

  MoodState copyWith({
    MoodStatus? status,
    List<MoodEntry>? entries,
    MoodStats? stats,
    String? errorMessage,
  }) {
    return MoodState(
      status: status ?? this.status,
      entries: entries ?? this.entries,
      stats: stats ?? this.stats,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, entries, stats, errorMessage];
}
