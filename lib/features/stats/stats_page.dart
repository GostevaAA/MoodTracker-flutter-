import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/mood/mood_bloc.dart';
import '../../blocs/mood/mood_state.dart';
import '../../core/widgets/app_card.dart';
import '../../domain/stats/mood_stats.dart';
import 'widgets/stat_card.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Статистика')),
      body: BlocBuilder<MoodBloc, MoodState>(
        builder: (context, state) {
          if (state.status == MoodStatus.loading ||
              state.status == MoodStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == MoodStatus.failure) {
            return Center(
              child: Text('Ошибка: ${state.errorMessage ?? "неизвестная"}'),
            );
          }

          final stats = state.stats;

          if (stats.totalEntries == 0) {
            return const _EmptyState();
          }

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _StatsGrid(stats: stats),
                  const SizedBox(height: 24),
                  const _PlaceholderForCharts(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Сетка карточек метрик.
class _StatsGrid extends StatelessWidget {
  const _StatsGrid({required this.stats});

  final MoodStats stats;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final cards = <Widget>[
      StatCard(
        icon: Icons.list_alt,
        label: 'Всего записей',
        value: '${stats.totalEntries}',
      ),
      StatCard(
        icon: Icons.local_fire_department,
        label: 'Текущий стрик',
        value: '${stats.currentStreak}',
        caption: _pluralDays(stats.currentStreak),
        valueColor: stats.currentStreak > 0
            ? colorScheme.primary
            : colorScheme.onSurfaceVariant,
      ),
      StatCard(
        icon: Icons.emoji_events_outlined,
        label: 'Лучший стрик',
        value: '${stats.longestStreak}',
        caption: _pluralDays(stats.longestStreak),
      ),
      StatCard(
        icon: Icons.calendar_view_week,
        label: 'За неделю',
        value: '${stats.entriesThisWeek}',
      ),
      StatCard(
        icon: Icons.calendar_month,
        label: 'За месяц',
        value: '${stats.entriesThisMonth}',
      ),
      StatCard(
        icon: Icons.trending_up,
        label: 'Среднее',
        value: _formatAverage(stats.averageMood),
        caption: stats.mostFrequentLevel != null
            ? 'Чаще всего: ${stats.mostFrequentLevel!.label}'
            : null,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 600 ? 3 : 2;
        return GridView.count(
          crossAxisCount: columns,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.15,
          children: cards,
        );
      },
    );
  }

  String _formatAverage(double? avg) {
    if (avg == null) return '—';
    return avg.toStringAsFixed(2);
  }

  String _pluralDays(int n) {
    if (n == 0) return 'дней';
    final mod10 = n % 10;
    final mod100 = n % 100;
    if (mod10 == 1 && mod100 != 11) return 'день';
    if (mod10 >= 2 && mod10 <= 4 && (mod100 < 12 || mod100 > 14)) {
      return 'дня';
    }
    return 'дней';
  }
}

/// Заглушка для графиков.
class _PlaceholderForCharts extends StatelessWidget {
  const _PlaceholderForCharts();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      child: Column(
        children: [
          Icon(
            Icons.show_chart,
            size: 40,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 12),
          Text(
            'Графики скоро появятся',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }
}

/// Пустое состояние, когда записей нет.
/// Растянуто на весь экран, контент по центру.
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.insights_outlined,
                size: 64,
                color: colorScheme.primary,
              ),
              const SizedBox(height: 20),
              Text(
                'Пока нет данных для статистики',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Добавь первую запись — и здесь появятся метрики',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
