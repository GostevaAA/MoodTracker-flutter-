/// Убирает время из даты — оставляет только год, месяц, день.
/// Критично для всего приложения: записи хранятся по дням, а не по моментам времени.
DateTime dateOnly(DateTime date) {
  return DateTime(date.year, date.month, date.day);
}

/// Проверяет, что две даты — один и тот же день (без учёта времени).
bool isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

/// Сегодняшняя дата без времени.
DateTime get today => dateOnly(DateTime.now());

/// Вчерашняя дата без времени.
DateTime get yesterday => today.subtract(const Duration(days: 1));
