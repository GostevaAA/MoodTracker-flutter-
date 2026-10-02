import 'package:flutter_test/flutter_test.dart';
import 'package:mood_tracker/core/constants/mood_level.dart';
import 'package:mood_tracker/data/models/mood_entry.dart';
import 'package:mood_tracker/domain/stats/mood_stats.dart';

MoodEntry _entry(DateTime date, MoodLevel level) {
  return MoodEntry(
    id: '${date.year}-${date.month}-${date.day}',
    date: date,
    moodLevel: level,
  );
}

void main() {
  group('MoodStats', () {
    test('пустой список возвращает empty', () {
      final stats = MoodStats.from([]);
      expect(stats.totalEntries, 0);
      expect(stats.currentStreak, 0);
      expect(stats.averageMood, isNull);
    });

    test('считает totalEntries и averageMood', () {
      final now = DateTime.now();
      final stats = MoodStats.from([
        _entry(now, MoodLevel.great), // 5
        _entry(now.subtract(const Duration(days: 1)), MoodLevel.okay), // 3
        _entry(now.subtract(const Duration(days: 2)), MoodLevel.good), // 4
      ]);
      expect(stats.totalEntries, 3);
      expect(stats.averageMood, closeTo(4.0, 0.001));
    });

    test('текущий стрик из трёх дней подряд', () {
      final now = DateTime.now();
      final stats = MoodStats.from([
        _entry(now, MoodLevel.great),
        _entry(now.subtract(const Duration(days: 1)), MoodLevel.okay),
        _entry(now.subtract(const Duration(days: 2)), MoodLevel.good),
      ]);
      expect(stats.currentStreak, 3);
    });

    test('стрик прерывается пропуском', () {
      final now = DateTime.now();
      final stats = MoodStats.from([
        _entry(now, MoodLevel.great),
        // пропуск на 1 день
        _entry(now.subtract(const Duration(days: 2)), MoodLevel.okay),
        _entry(now.subtract(const Duration(days: 3)), MoodLevel.good),
      ]);
      expect(stats.currentStreak, 1);
    });

    test('стрик живой, если последняя запись вчера', () {
      final now = DateTime.now();
      final stats = MoodStats.from([
        _entry(now.subtract(const Duration(days: 1)), MoodLevel.great),
        _entry(now.subtract(const Duration(days: 2)), MoodLevel.okay),
      ]);
      expect(stats.currentStreak, 2);
    });

    test('стрик не живой, если последняя запись позавчера', () {
      final now = DateTime.now();
      final stats = MoodStats.from([
        _entry(now.subtract(const Duration(days: 2)), MoodLevel.great),
        _entry(now.subtract(const Duration(days: 3)), MoodLevel.okay),
      ]);
      expect(stats.currentStreak, 0);
    });

    test('longestStreak находит самую длинную серию', () {
      final now = DateTime.now();
      final stats = MoodStats.from([
        // серия 3 дня
        _entry(now, MoodLevel.great),
        _entry(now.subtract(const Duration(days: 1)), MoodLevel.okay),
        _entry(now.subtract(const Duration(days: 2)), MoodLevel.good),
        // пропуск
        // серия 2 дня
        _entry(now.subtract(const Duration(days: 10)), MoodLevel.bad),
        _entry(now.subtract(const Duration(days: 11)), MoodLevel.awful),
      ]);
      expect(stats.longestStreak, 3);
    });

    test('распределение уровней', () {
      final now = DateTime.now();
      final stats = MoodStats.from([
        _entry(now, MoodLevel.great),
        _entry(now.subtract(const Duration(days: 1)), MoodLevel.great),
        _entry(now.subtract(const Duration(days: 2)), MoodLevel.okay),
      ]);
      expect(stats.moodDistribution[MoodLevel.great], 2);
      expect(stats.moodDistribution[MoodLevel.okay], 1);
      expect(stats.mostFrequentLevel, MoodLevel.great);
    });

    test('дубликаты по дате не считаются дважды', () {
      final now = DateTime.now();
      final stats = MoodStats.from([
        _entry(now, MoodLevel.great),
        _entry(now, MoodLevel.awful), // тот же день, другой уровень
      ]);
      expect(stats.totalEntries, 1);
    });
  });
}
