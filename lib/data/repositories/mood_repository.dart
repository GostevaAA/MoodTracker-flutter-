import 'package:drift/drift.dart';

import '../../core/constants/mood_level.dart';
import '../../core/utils/date_utils.dart' as date_utils;
import '../datasources/app_database.dart';
import '../models/mood_entry.dart';

/// Слой между базой данных и остальным приложением.
/// Скрывает от UI детали Drift и работает с нашей моделью MoodEntry.
class MoodRepository {
  MoodRepository(this._db);

  final AppDatabase _db;

  // ─────────────────────────────────────────────────────────────
  // Чтение
  // ─────────────────────────────────────────────────────────────

  /// Реактивный стрим всех записей (от новых к старым).
  /// При любом изменении в БД стрим эмитит новое значение.
  Stream<List<MoodEntry>> watchAll() {
    final query = _db.select(_db.moodEntries)
      ..orderBy([(t) => OrderingTerm.desc(t.date)]);
    return query.watch().map(
          (rows) => rows.map(_toModel).toList(),
        );
  }

  /// Реактивный стрим записей за указанный диапазон дат (включительно).
  Stream<List<MoodEntry>> watchRange(DateTime from, DateTime to) {
    final fromDate = date_utils.dateOnly(from);
    final toDate = date_utils.dateOnly(to);
    final query = _db.select(_db.moodEntries)
      ..where((t) => t.date.isBetweenValues(fromDate, toDate))
      ..orderBy([(t) => OrderingTerm.desc(t.date)]);
    return query.watch().map(
          (rows) => rows.map(_toModel).toList(),
        );
  }

  /// Одноразовое чтение всех записей (для статистики, экспорта и т.п.).
  Future<List<MoodEntry>> getAll() async {
    final query = _db.select(_db.moodEntries)
      ..orderBy([(t) => OrderingTerm.desc(t.date)]);
    final rows = await query.get();
    return rows.map(_toModel).toList();
  }

  /// Запись за конкретный день или null, если её нет.
  Future<MoodEntry?> getByDate(DateTime date) async {
    final day = date_utils.dateOnly(date);
    final query = _db.select(_db.moodEntries)..where((t) => t.date.equals(day));
    final row = await query.getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  // ─────────────────────────────────────────────────────────────
  // Запись
  // ─────────────────────────────────────────────────────────────

  /// Создать или обновить запись (upsert по id).
  Future<void> upsert(MoodEntry entry) async {
    await _db.into(_db.moodEntries).insertOnConflictUpdate(
          _toCompanion(entry),
        );
  }

  /// Удалить запись по id.
  Future<void> deleteById(String id) async {
    await (_db.delete(_db.moodEntries)..where((t) => t.id.equals(id))).go();
  }

  // ─────────────────────────────────────────────────────────────
  // Маппинг: Drift-строка ↔ наша модель
  // ─────────────────────────────────────────────────────────────

  MoodEntry _toModel(MoodEntryRow row) {
    return MoodEntry(
      id: row.id,
      date: row.date,
      moodLevel: MoodLevel.fromValue(row.moodLevel),
      note: row.note,
      tags: _parseTags(row.tags),
    );
  }

  MoodEntriesCompanion _toCompanion(MoodEntry entry) {
    return MoodEntriesCompanion(
      id: Value(entry.id),
      date: Value(date_utils.dateOnly(entry.date)),
      moodLevel: Value(entry.moodLevel.value),
      note: Value(entry.note),
      tags: Value(_serializeTags(entry.tags)),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // Теги: хранение в CSV-строке
  // ─────────────────────────────────────────────────────────────

  List<String> _parseTags(String raw) {
    if (raw.isEmpty) return const [];
    return raw.split(',').where((t) => t.isNotEmpty).toList();
  }

  String _serializeTags(List<String> tags) {
    return tags.where((t) => t.isNotEmpty).join(',');
  }
}
