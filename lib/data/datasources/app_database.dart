import 'package:sembast/sembast_memory.dart';

/// Обёртка над sembast: открывает БД и даёт доступ к стору записей.
class AppDatabase {
  AppDatabase._(this.db);

  final Database db;

  /// Стор, где хранятся записи настроения.
  static final StoreRef<String, Map<String, Object?>> moodStore =
      stringMapStoreFactory.store('mood_entries');

  static Future<AppDatabase> open() async {
    // Временное решение для Chrome — данные не сохраняются между перезапусками
    final db = await databaseFactoryMemory.openDatabase('mood_tracker.db');
    return AppDatabase._(db);
  }
}
