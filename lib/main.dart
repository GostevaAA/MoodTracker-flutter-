import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/utils/date_formatter.dart';
import 'data/datasources/app_database.dart';
import 'data/repositories/theme_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DateFormatter.init();
  final database = await AppDatabase.open();
  final prefs = await SharedPreferences.getInstance();
  final themeRepository = ThemeRepository(prefs);

  runApp(MoodTrackerApp(
    database: database,
    themeRepository: themeRepository,
  ));
}
