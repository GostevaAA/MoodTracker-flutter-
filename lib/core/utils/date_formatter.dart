import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'date_utils.dart' as date_utils;

/// Хелпер для форматирования дат в русском стиле.
class DateFormatter {
  const DateFormatter._();

  static bool _initialized = false;

  /// Вызывается один раз при старте приложения.
  static Future<void> init() async {
    if (_initialized) return;
    await initializeDateFormatting('ru', null);
    _initialized = true;
  }

  /// «Сегодня», «Вчера», или полная дата «12 мая 2025».
  static String humanReadable(DateTime date) {
    final day = date_utils.dateOnly(date);
    final today = date_utils.today;
    final yesterday = date_utils.yesterday;

    if (date_utils.isSameDay(day, today)) return 'Сегодня';
    if (date_utils.isSameDay(day, yesterday)) return 'Вчера';

    return DateFormat('d MMMM y', 'ru').format(day);
  }

  /// Полная дата с днём недели: «Понедельник, 12 мая 2025».
  static String fullWithWeekday(DateTime date) {
    final formatted = DateFormat('EEEE, d MMMM y', 'ru').format(date);
    // Делаем первую букву заглавной
    return formatted[0].toUpperCase() + formatted.substring(1);
  }

  /// Короткая дата для списков: «12 мая».
  static String shortDate(DateTime date) {
    return DateFormat('d MMMM', 'ru').format(date);
  }

  /// День недели: «Понедельник».
  static String weekday(DateTime date) {
    final formatted = DateFormat('EEEE', 'ru').format(date);
    return formatted[0].toUpperCase() + formatted.substring(1);
  }
}
