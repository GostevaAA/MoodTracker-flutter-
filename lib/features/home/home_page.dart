import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/mood/mood_bloc.dart';
import '../../blocs/mood/mood_state.dart';
import '../../core/utils/date_utils.dart' as date_utils;
import '../../core/widgets/mood_icon.dart';
import '../editor/editor_page.dart';
import 'widgets/mood_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _focusedDay = date_utils.today;
  DateTime _selectedDay = date_utils.today;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mood Tracker')),
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

          final selectedEntries = state.entries
              .where((e) => date_utils.isSameDay(e.date, _selectedDay))
              .toList();

          return Column(
            children: [
              MoodCalendar(
                entries: state.entries,
                focusedDay: _focusedDay,
                selectedDay: _selectedDay,
                onDaySelected: (selected, focused) {
                  setState(() {
                    _selectedDay = selected;
                    _focusedDay = focused;
                  });
                },
                onPageChanged: (focused) {
                  _focusedDay = focused;
                },
              ),
              const Divider(height: 1),
              Expanded(
                child: selectedEntries.isEmpty
                    ? const Center(
                        child: Text('На этот день записи нет'),
                      )
                    : ListView.builder(
                        itemCount: selectedEntries.length,
                        itemBuilder: (context, index) {
                          final entry = selectedEntries[index];
                          return ListTile(
                            leading: MoodIcon(level: entry.moodLevel),
                            title: Text(entry.moodLevel.label),
                            subtitle:
                                entry.note != null && entry.note!.isNotEmpty
                                    ? Text(entry.note!)
                                    : null,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => EditorPage(existing: entry),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => EditorPage(initialDate: _selectedDay),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
