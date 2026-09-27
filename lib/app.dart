import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/mood/mood_bloc.dart';
import 'blocs/mood/mood_event.dart';
import 'data/datasources/app_database.dart';
import 'data/repositories/mood_repository.dart';
import 'features/home/home_page.dart';

class MoodTrackerApp extends StatelessWidget {
  const MoodTrackerApp({super.key, required this.database});

  final AppDatabase database;

  @override
  Widget build(BuildContext context) {
    final repository = MoodRepository(database);

    return BlocProvider(
      create: (_) => MoodBloc(repository)..add(const MoodStarted()),
      child: MaterialApp(
        title: 'Mood Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
