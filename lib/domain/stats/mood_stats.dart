import '../../../core/constants/mood_level.dart';
import '../../../core/utils/date_utils.dart' as date_utils;
import '../../../data/models/mood_entry.dart';

/// Вычисляемая статистика по набору записей настроения.
/// Чистый класс без зависимостей от Flutter — легко тестируется.
class MoodStats {
  const MoodStats({
    required this.totalEntries,
    required this.currentStreak,
    required this.longestStreak,
    required this.entriesThisWeek,
    required this.entriesThisMonth,
    required this.averageMood,
    required this.mostFrequentLevel,
    required this.moodDistribution,
    required this.averageByWeekday,
    required this.entries,
  });

  /// Всего записей.
  final int totalEntries;

  /// Текущий стрик — сколько дней подряд есть записи,
  /// считая от сегодня (или от вчера, если сегодня ещё нет).
  final int currentStreak;

  /// Самый длинный стрик за всё время.
  final int longestStreak;

  /// Записей за последние 7 дней (включая сегодня).
  final int entriesThisWeek;

  /// Записей за текущий календарный месяц.
  final int entriesThisMonth;

  /// Средний уровень настроения за всё время.
  /// null, если записей нет.
  final double? averageMood;

  /// Самый частый уровень настроения.
  /// null, если записей нет.
  final MoodLevel? mostFrequentLevel;

  /// Распределение по уровням: сколько раз был каждый.
  final Map<MoodLevel, int> moodDistribution;

  /// Средний уровень по дням недели.
  /// Ключ — DateTime.weekday (1 = Пн, 7 = Вс).
  /// null для дней, по которым нет данных.
  final Map<int, double?> averageByWeekday;

  /// Записи, по которым считалась статистика (для графиков).
  final List<MoodEntry> entries;

  /// Пустая статистика для случая, когда записей нет.
  static const empty = MoodStats(
    totalEntries: 0,
    currentStreak: 0,
    longestStreak: 0,
    entriesThisWeek: 0,
    entriesThisMonth: 0,
    averageMood: null,
    mostFrequentLevel: null,
    moodDistribution: {},
    averageByWeekday: {},
    entries: [],
  );

  /// Считает статистику из набора записей.
  factory MoodStats.from(List<MoodEntry> entries) {
    if (entries.isEmpty) return empty;

    // Нормализуем даты и убираем возможные дубликаты по дате
    // (на всякий случай — по правилам их быть не должно).
    final byDate = <DateTime, MoodEntry>{};
    for (final e in entries) {
      byDate[date_utils.dateOnly(e.date)] = e;
    }
    final sorted = byDate.keys.toList()..sort();

    return MoodStats(
      totalEntries: byDate.length,
      currentStreak: _currentStreak(sorted),
      longestStreak: _longestStreak(sorted),
      entriesThisWeek: _countInLastDays(sorted, 7),
      entriesThisMonth: _countInCurrentMonth(sorted),
      averageMood: _averageMood(entries),
      mostFrequentLevel: _mostFrequentLevel(entries),
      moodDistribution: _distribution(entries),
      averageByWeekday: _averageByWeekday(entries),
      entries: entries,
    );
  }

  // ─────────────────────────────────────────────────────────────
  // Вычисления
  // ─────────────────────────────────────────────────────────────

  /// Текущий стрик: считаем от сегодня назад по последовательным дням.
  /// Если сегодня записи нет, но вчера есть — стрик продолжается
  /// (пользователь ещё успеет написать сегодня).
  static int _currentStreak(List<DateTime> sortedDays) {
    if (sortedDays.isEmpty) return 0;

    final today = date_utils.today;
    final yesterday = today.subtract(const Duration(days: 1));

    final last = sortedDays.last;
    if (last != today && last != yesterday) return 0;

    int streak = 1;
    for (int i = sortedDays.length - 1; i > 0; i--) {
      final diff = sortedDays[i].difference(sortedDays[i - 1]).inDays;
      if (diff == 1) {
        streak++;
      } else {
        break;
      }
    }
    return streak;
  }

  /// Самый длинный стрик за всё время.
  static int _longestStreak(List<DateTime> sortedDays) {
    if (sortedDays.isEmpty) return 0;

    int longest = 1;
    int current = 1;
    for (int i = 1; i < sortedDays.length; i++) {
      final diff = sortedDays[i].difference(sortedDays[i - 1]).inDays;
      if (diff == 1) {
        current++;
        if (current > longest) longest = current;
      } else {
        current = 1;
      }
    }
    return longest;
  }

  /// Сколько записей попадает в последние [days] дней (включая сегодня).
  static int _countInLastDays(List<DateTime> sortedDays, int days) {
    final today = date_utils.today;
    final from = today.subtract(Duration(days: days - 1));
    return sortedDays.where((d) => !d.isBefore(from)).length;
  }

  /// Сколько записей в текущем календарном месяце.
  static int _countInCurrentMonth(List<DateTime> sortedDays) {
    final today = date_utils.today;
    return sortedDays
        .where((d) => d.year == today.year && d.month == today.month)
        .length;
  }

  /// Средний уровень настроения.
  static double? _averageMood(List<MoodEntry> entries) {
    if (entries.isEmpty) return null;
    final sum = entries.fold<int>(0, (acc, e) => acc + e.moodLevel.value);
    return sum / entries.length;
  }

  /// Самый частый уровень настроения. При равенстве — берём более высокий.
  static MoodLevel? _mostFrequentLevel(List<MoodEntry> entries) {
    if (entries.isEmpty) return null;
    final counts = _distribution(entries);
    MoodLevel? best;
    int bestCount = 0;
    for (final level in MoodLevel.values) {
      final count = counts[level] ?? 0;
      if (count >= bestCount) {
        bestCount = count;
        best = level;
      }
    }
    return best;
  }

  /// Сколько раз встречается каждый уровень.
  static Map<MoodLevel, int> _distribution(List<MoodEntry> entries) {
    final result = <MoodLevel, int>{};
    for (final e in entries) {
      result[e.moodLevel] = (result[e.moodLevel] ?? 0) + 1;
    }
    return result;
  }

  /// Средний уровень по каждому дню недели.
  /// Для дней без записей значение — null.
  static Map<int, double?> _averageByWeekday(List<MoodEntry> entries) {
    final sums = <int, int>{};
    final counts = <int, int>{};
    for (final e in entries) {
      final wd = e.date.weekday;
      sums[wd] = (sums[wd] ?? 0) + e.moodLevel.value;
      counts[wd] = (counts[wd] ?? 0) + 1;
    }
    final result = <int, double?>{};
    for (int wd = 1; wd <= 7; wd++) {
      final count = counts[wd] ?? 0;
      result[wd] = count == 0 ? null : sums[wd]! / count;
    }
    return result;
  }
}
