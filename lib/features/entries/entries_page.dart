import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/mood/mood_bloc.dart';
import '../../blocs/mood/mood_event.dart';
import '../../blocs/mood/mood_state.dart';
import '../../core/utils/date_formatter.dart';
import '../../core/utils/entries_grouper.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/mood_icon.dart';
import '../../data/models/mood_entry.dart';
import '../editor/editor_page.dart';

class EntriesPage extends StatelessWidget {
  const EntriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Все записи')),
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
          if (state.entries.isEmpty) {
            return const Center(child: Text('Пока нет записей'));
          }

          final groups = groupByMonth(state.entries);

          return SafeArea(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              itemCount: groups.length,
              itemBuilder: (context, index) {
                return _MonthSection(group: groups[index]);
              },
            ),
          );
        },
      ),
    );
  }
}

class _MonthSection extends StatelessWidget {
  const _MonthSection({required this.group});

  final MonthGroup group;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 16, 4, 8),
          child: Text(
            DateFormatter.monthWithYear(group.year, group.month),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
        ...group.entries.map(
          (entry) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _EntryCard(entry: entry),
          ),
        ),
      ],
    );
  }
}

class _EntryCard extends StatelessWidget {
  const _EntryCard({required this.entry});

  final MoodEntry entry;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Dismissible(
      key: ValueKey(entry.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: colorScheme.error,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(Icons.delete, color: colorScheme.onError),
      ),
      onDismissed: (_) => _deleteWithUndo(context, entry),
      child: AppCard(
        padding: const EdgeInsets.all(16),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => EditorPage(existing: entry),
            ),
          );
        },
        child: Row(
          children: [
            MoodIcon(level: entry.moodLevel, size: 40),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.moodLevel.label,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    entry.note != null && entry.note!.isNotEmpty
                        ? entry.note!
                        : DateFormatter.shortDate(entry.date),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
                  if (entry.tags.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: entry.tags
                          .map(
                            (tag) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.secondaryContainer,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                tag,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: colorScheme.onSecondaryContainer,
                                    ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              DateFormatter.shortDate(entry.date),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteWithUndo(BuildContext context, MoodEntry entry) {
    final bloc = context.read<MoodBloc>();
    final messenger = ScaffoldMessenger.of(context);

    bloc.add(MoodEntryDeleted(entry.id));

    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        content: const Text('Запись удалена'),
        action: SnackBarAction(
          label: 'Отменить',
          onPressed: () => bloc.add(MoodEntryRestored(entry)),
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }
}
