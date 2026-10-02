import 'package:sembast/sembast.dart';

import '../../core/constants/mood_level.dart';
import '../../core/utils/date_utils.dart' as date_utils;
import '../datasources/app_database.dart';
import '../models/mood_entry.dart';
import 'save_result.dart';

class MoodRepository {
  MoodRepository(this._database);

  final AppDatabase _database;
  Database get _db => _database.db;
  StoreRef<String, Map<String, Object?>> get _store => AppDatabase.moodStore;

  // ─────────────────────────────────────────────────────────────
  // Чтение
  // ─────────────────────────────────────────────────────────────

  Stream<List<MoodEntry>> watchAll() {
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

  // ─────────────────────────────────────────────────────────────
  // Запись
  // ─────────────────────────────────────────────────────────────

  /// Сохранить запись с проверкой конфликта по дате.
  ///
  /// Если на выбранной дате уже есть *другая* запись (с другим id),
  /// вернёт [SaveConflict] вместо сохранения — UI решит, заменить или нет.
  /// Если конфликта нет — сохранит и вернёт [SaveSuccess].
  Future<SaveResult> saveEntry(MoodEntry entry) async {
    final conflict = await _findByDateExcludingId(entry.date, entry.id);
    if (conflict != null) {
      return SaveConflict(conflict);
    }
    await _store.record(entry.id).put(_db, _toMap(entry));
    return SaveSuccess(entry);
  }

  /// Сохранить запись, заменив конфликтную (вызывается после подтверждения).
  Future<void> replaceEntry(MoodEntry entry, MoodEntry conflict) async {
    await _store.record(conflict.id).delete(_db);
    await _store.record(entry.id).put(_db, _toMap(entry));
  }

  Future<void> deleteById(String id) async {
    await _store.record(id).delete(_db);
  }

  // ─────────────────────────────────────────────────────────────
  // Внутреннее
  // ─────────────────────────────────────────────────────────────

  /// Найти запись на указанной дате, исключая запись с заданным id.
  Future<MoodEntry?> _findByDateExcludingId(
    DateTime date,
    String excludedId,
  ) async {
    final day = date_utils.dateOnly(date);
    final records = await _store.find(_db);
    for (final r in records) {
      if (r.key == excludedId) continue;
      final entry = _fromMap(r.key, r.value);
      if (date_utils.isSameDay(entry.date, day)) return entry;
    }
    return null;
  }

  /// Заменить все записи на переданные.
  /// Удаляет всё, что было, и записывает новый набор.
  Future<void> replaceAll(List<MoodEntry> entries) async {
    await _store.delete(_db);
    for (final entry in entries) {
      await _store.record(entry.id).put(_db, _toMap(entry));
    }
  }

  // ─────────────────────────────────────────────────────────────
  // Маппинг
  // ─────────────────────────────────────────────────────────────

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
