import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/mood/mood_bloc.dart';
import '../../blocs/mood/mood_event.dart';
import '../../blocs/mood/mood_state.dart';
import '../../core/utils/date_formatter.dart';
import '../../core/utils/entries_grouper.dart';
import '../../data/models/mood_entry.dart';
import '../editor/editor_page.dart';
import 'widgets/mood_entry_tile.dart';

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
            return const Center(
              child: Text('Пока нет записей'),
            );
          }

          final groups = groupByMonth(state.entries);

          return ListView.builder(
            itemCount: groups.length,
            itemBuilder: (context, index) {
              final group = groups[index];
              return _MonthSection(
                group: group,
              );
            },
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
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            DateFormatter.monthWithYear(group.year, group.month),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
        ...group.entries.map(
          (entry) => MoodEntryTile(
            entry: entry,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => EditorPage(existing: entry),
                ),
              );
            },
            onDelete: () => _deleteWithUndo(context, entry),
          ),
        ),
      ],
    );
  }

  void _deleteWithUndo(BuildContext context, MoodEntry entry) {
    final bloc = context.read<MoodBloc>();
    final messenger = ScaffoldMessenger.of(context);

    // Удаляем
    bloc.add(MoodEntryDeleted(entry.id));

    // Показываем SnackBar с undo
    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        content: const Text('Запись удалена'),
        action: SnackBarAction(
          label: 'Отменить',
          onPressed: () {
            // Возвращаем запись обратно тем же id
            bloc.add(MoodEntryAdded(entry));
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }
}
