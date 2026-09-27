import 'package:flutter/material.dart';

import 'app.dart';
import 'core/utils/date_formatter.dart';
import 'data/datasources/app_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DateFormatter.init();
  final database = await AppDatabase.open();
  runApp(MoodTrackerApp(database: database));
}
