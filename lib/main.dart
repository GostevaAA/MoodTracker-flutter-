import 'package:flutter/material.dart';

import 'app.dart';
import 'data/datasources/app_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await AppDatabase.open();
  runApp(MoodTrackerApp(database: database));
}
