import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/utils/date_utils.dart' as date_utils;
import '../../../core/widgets/mood_icon.dart';
import '../../../data/models/mood_entry.dart';

class MoodCalendar extends StatelessWidget {
  const MoodCalendar({
    super.key,
    required this.entries,
    required this.focusedDay,
    required this.selectedDay,
    required this.onDaySelected,
    required this.onPageChanged,
  });

  final List<MoodEntry> entries;
  final DateTime focusedDay;
  final DateTime selectedDay;
  final void Function(DateTime selected, DateTime focused) onDaySelected;
  final void Function(DateTime focused) onPageChanged;

  Map<DateTime, MoodEntry> get _entriesByDate {
    final map = <DateTime, MoodEntry>{};
    for (final entry in entries) {
      map[date_utils.dateOnly(entry.date)] = entry;
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    final byDate = _entriesByDate;
    final theme = Theme.of(context);

    return TableCalendar<MoodEntry>(
      locale: 'ru_RU',
      firstDay: DateTime(2020),
      lastDay: DateTime.now().add(const Duration(days: 365)),
      focusedDay: focusedDay,
      selectedDayPredicate: (day) => date_utils.isSameDay(day, selectedDay),
      eventLoader: (day) {
        final entry = byDate[date_utils.dateOnly(day)];
        return entry != null ? [entry] : const [];
      },
      onDaySelected: onDaySelected,
      onPageChanged: onPageChanged,
      availableGestures: AvailableGestures.horizontalSwipe,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        leftChevronIcon: Icon(
          Icons.chevron_left,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        rightChevronIcon: Icon(
          Icons.chevron_right,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        titleTextStyle: theme.textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      daysOfWeekHeight: 24,
      rowHeight: 56,
      calendarStyle: const CalendarStyle(
        markersMaxCount: 0,
        markersAutoAligned: false,
        outsideDaysVisible: true,
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        weekendStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      calendarBuilders: CalendarBuilders<MoodEntry>(
        defaultBuilder: (context, day, focusedDay) => _DayCell(
          day: day,
          entry: byDate[date_utils.dateOnly(day)],
          isSelected: false,
          isToday: false,
          isOutside: false,
        ),
        todayBuilder: (context, day, focusedDay) => _DayCell(
          day: day,
          entry: byDate[date_utils.dateOnly(day)],
          isSelected: false,
          isToday: true,
          isOutside: false,
        ),
        selectedBuilder: (context, day, focusedDay) => _DayCell(
          day: day,
          entry: byDate[date_utils.dateOnly(day)],
          isSelected: true,
          isToday: false,
          isOutside: false,
        ),
        outsideBuilder: (context, day, focusedDay) => _DayCell(
          day: day,
          entry: byDate[date_utils.dateOnly(day)],
          isSelected: false,
          isToday: false,
          isOutside: true,
        ),
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.entry,
    required this.isSelected,
    required this.isToday,
    required this.isOutside,
  });

  final DateTime day;
  final MoodEntry? entry;
  final bool isSelected;
  final bool isToday;
  final bool isOutside;

  static const double _iconSize = 28;
  static const double _highlightSize = 36;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final Color textColor;
    final FontWeight textWeight;
    if (isSelected) {
      textColor = colorScheme.primary;
      textWeight = FontWeight.bold;
    } else if (isToday) {
      textColor = colorScheme.primary;
      textWeight = FontWeight.w700;
    } else {
      textColor = colorScheme.onSurfaceVariant;
      textWeight = FontWeight.w400;
    }

    final Widget moodSlot = entry != null
        ? MoodIcon(level: entry!.moodLevel, size: _iconSize)
        : Container(
            width: _iconSize,
            height: _iconSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: colorScheme.outlineVariant,
                width: 1,
              ),
            ),
          );

    BoxDecoration? highlightDecoration;
    if (isSelected) {
      highlightDecoration = BoxDecoration(
        shape: BoxShape.circle,
        color: colorScheme.primary.withValues(alpha: 0.18),
      );
    } else if (isToday) {
      highlightDecoration = BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: colorScheme.primary, width: 2),
      );
    }

    final cell = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: _highlightSize,
          height: _highlightSize,
          decoration: highlightDecoration,
          alignment: Alignment.center,
          child: moodSlot,
        ),
        const SizedBox(height: 2),
        Text(
          '${day.day}',
          style: TextStyle(
            fontSize: 11,
            fontWeight: textWeight,
            color: textColor,
            height: 1.0,
          ),
        ),
      ],
    );

    return Opacity(
      opacity: isOutside ? 0.35 : 1.0,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: cell,
      ),
    );
  }
}
