import 'package:equatable/equatable.dart';

import '../../core/constants/mood_level.dart';

class MoodEntry extends Equatable {
  const MoodEntry({
    required this.id,
    required this.date,
    required this.moodLevel,
    this.note,
    this.tags = const [],
  });

  final String id;
  final DateTime date;
  final MoodLevel moodLevel;
  final String? note;
  final List<String> tags;

  @override
  List<Object?> get props => [id, date, moodLevel, note, tags];

  MoodEntry copyWith({
    String? id,
    DateTime? date,
    MoodLevel? moodLevel,
    String? note,
    List<String>? tags,
  }) {
    return MoodEntry(
      id: id ?? this.id,
      date: date ?? this.date,
      moodLevel: moodLevel ?? this.moodLevel,
      note: note ?? this.note,
      tags: tags ?? this.tags,
    );
  }
}
