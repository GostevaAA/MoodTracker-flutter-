import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/mood/mood_bloc.dart';
import '../../blocs/mood/mood_state.dart';
import '../../core/widgets/mood_icon.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Tracker'),
      ),
      body: BlocBuilder<MoodBloc, MoodState>(
        builder: (context, state) {
          switch (state.status) {
            case MoodStatus.initial:
            case MoodStatus.loading:
              return const Center(child: CircularProgressIndicator());

            case MoodStatus.failure:
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    'Ошибка: ${state.errorMessage ?? "неизвестная"}',
                    textAlign: TextAlign.center,
                  ),
                ),
              );

            case MoodStatus.ready:
              if (state.entries.isEmpty) {
                return const Center(
                  child: Text('Пока нет записей'),
                );
              }
              return ListView.builder(
                itemCount: state.entries.length,
                itemBuilder: (context, index) {
                  final entry = state.entries[index];
                  return ListTile(
                    leading: MoodIcon(level: entry.moodLevel),
                    title: Text(
                      '${entry.date.day}.${entry.date.month}.${entry.date.year}',
                    ),
                    subtitle: entry.note != null && entry.note!.isNotEmpty
                        ? Text(entry.note!)
                        : Text(entry.moodLevel.label),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
