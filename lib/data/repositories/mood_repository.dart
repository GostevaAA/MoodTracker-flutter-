import 'package:sembast/sembast.dart';

import '../../core/constants/mood_level.dart';
import '../../core/utils/date_utils.dart' as date_utils;
import '../datasources/app_database.dart';
import '../models/mood_entry.dart';

class MoodRepository {
  MoodRepository(this._database);

  final AppDatabase _database;
  Database get _db => _database.db;
  StoreRef<String, Map<String, Object?>> get _store => AppDatabase.moodStore;

  // ─── Чтение ───

  Stream<List<MoodEntry>> watchAll() {
    // onSnapshots даёт стрим всех изменений в сторе
    return _store.query().onSnapshots(_db).map(
          (snapshots) => snapshots.map((s) => _fromMap(s.key, s.value)).toList()
            ..sort((a, b) => b.date.compareTo(a.date)),
        );
  }

  Future<List<MoodEntry>> getAll() async {
    final records = await _store.find(_db);
    final entries = records.map((r) => _fromMap(r.key, r.value)).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
    return entries;
  }

  Future<MoodEntry?> getByDate(DateTime date) async {
    final day = date_utils.dateOnly(date);
    final records = await _store.find(_db);
    for (final r in records) {
      final entry = _fromMap(r.key, r.value);
      if (date_utils.isSameDay(entry.date, day)) return entry;
    }
    return null;
  }

  // ─── Запись ───

  Future<void> upsert(MoodEntry entry) async {
    await _store.record(entry.id).put(_db, _toMap(entry));
  }

  Future<void> deleteById(String id) async {
    await _store.record(id).delete(_db);
  }

  // ─── Маппинг ───

  MoodEntry _fromMap(String id, Map<String, Object?> map) {
    return MoodEntry(
      id: id,
      date: DateTime.parse(map['date'] as String),
      moodLevel: MoodLevel.fromValue(map['moodLevel'] as int),
      note: map['note'] as String?,
      tags: (map['tags'] as List?)?.cast<String>() ?? const [],
    );
  }

  Map<String, Object?> _toMap(MoodEntry entry) {
    return {
      'date': date_utils.dateOnly(entry.date).toIso8601String(),
      'moodLevel': entry.moodLevel.value,
      'note': entry.note,
      'tags': entry.tags,
    };
  }
}
