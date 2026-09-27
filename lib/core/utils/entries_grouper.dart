import '../../data/models/mood_entry.dart';

/// Группа записей за один месяц.
class MonthGroup {
  const MonthGroup({
    required this.year,
    required this.month,
    required this.entries,
  });

  final int year;
  final int month;
  final List<MoodEntry> entries;
}

/// Группирует записи по месяцам, от новых к старым.
/// Внутри месяца — тоже от новых к старым.
List<MonthGroup> groupByMonth(List<MoodEntry> entries) {
  final map = <String, List<MoodEntry>>{};

  for (final entry in entries) {
    final key = '${entry.date.year}-${entry.date.month}';
    map.putIfAbsent(key, () => []).add(entry);
  }

  final groups = map.entries.map((e) {
    final parts = e.key.split('-');
    final year = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final sorted = [...e.value]..sort((a, b) => b.date.compareTo(a.date));
    return MonthGroup(year: year, month: month, entries: sorted);
  }).toList();

  // Сортируем группы: сначала новые
  groups.sort((a, b) {
    if (a.year != b.year) return b.year.compareTo(a.year);
    return b.month.compareTo(a.month);
  });

  return groups;
}
