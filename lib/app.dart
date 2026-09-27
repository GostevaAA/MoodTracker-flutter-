import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/mood/mood_bloc.dart';
import 'blocs/mood/mood_event.dart';
import 'blocs/theme/theme_bloc.dart';
import 'blocs/theme/theme_event.dart';
import 'blocs/theme/theme_state.dart';
import 'core/theme/app_theme.dart';
import 'data/datasources/app_database.dart';
import 'data/repositories/mood_repository.dart';
import 'data/repositories/theme_repository.dart';
import 'features/main_scaffold.dart';

class MoodTrackerApp extends StatelessWidget {
  const MoodTrackerApp({
    super.key,
    required this.database,
    required this.themeRepository,
  });

  final AppDatabase database;
  final ThemeRepository themeRepository;

  @override
  Widget build(BuildContext context) {
    final moodRepository = MoodRepository(database);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<MoodRepository>.value(value: moodRepository),
        RepositoryProvider<ThemeRepository>.value(value: themeRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => MoodBloc(moodRepository)..add(const MoodStarted()),
          ),
          BlocProvider(
            create: (_) =>
                ThemeBloc(themeRepository)..add(const ThemeStarted()),
          ),
        ],
        child: const _AppView(),
      ),
    );
  }
}

/// Отдельный виджет, чтобы получить доступ к ThemeBloc через context
/// и построить MaterialApp с нужной темой.
class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp(
          title: 'Mood Tracker',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(themeState.preset),
          darkTheme: AppTheme.dark(themeState.preset),
          themeMode: themeState.mode,
          home: const MainScaffold(),
        );
      },
    );
  }
}
