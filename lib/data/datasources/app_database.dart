import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

/// Таблица для хранения записей настроения.
@DataClassName('MoodEntryRow')
class MoodEntries extends Table {
  /// Уникальный идентификатор (строковый, генерируем сами через uuid).
  TextColumn get id => text()();

  /// Дата записи (без времени — только год, месяц, день).
  DateTimeColumn get date => dateTime()();

  /// Уровень настроения от 1 (плохо) до 5 (отлично).
  IntColumn get moodLevel => integer()();

  /// Опциональная заметка.
  TextColumn get note => text().nullable()();

  /// Теги/факторы, хранятся как CSV-строка.
  TextColumn get tags => text().withDefault(const Constant(''))();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [MoodEntries])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'mood_tracker_db');
  }
}
