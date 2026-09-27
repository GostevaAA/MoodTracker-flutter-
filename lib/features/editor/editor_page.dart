import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../blocs/mood/mood_bloc.dart';
import '../../blocs/mood/mood_event.dart';
import '../../core/constants/mood_level.dart';
import '../../core/utils/date_formatter.dart';
import '../../core/utils/date_utils.dart' as date_utils;
import '../../core/widgets/app_card.dart';
import '../../core/widgets/mood_icon.dart';
import '../../data/models/mood_entry.dart';
import '../../data/repositories/mood_repository.dart';

class EditorPage extends StatefulWidget {
  const EditorPage({super.key, this.existing, this.initialDate});

  final MoodEntry? existing;
  final DateTime? initialDate;

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  late MoodLevel _moodLevel;
  late DateTime _date;
  late TextEditingController _noteController;

  bool get _isEditing => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _moodLevel = existing?.moodLevel ?? MoodLevel.okay;
    _date = existing?.date ?? widget.initialDate ?? date_utils.today;
    _noteController = TextEditingController(text: existing?.note ?? '');
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final repository = context.read<MoodRepository>();
    final bloc = context.read<MoodBloc>();

    final noteText = _noteController.text.trim();
    final note = noteText.isEmpty ? null : noteText;

    if (_isEditing) {
      bloc.add(MoodEntryUpdated(MoodEntry(
        id: widget.existing!.id,
        date: _date,
        moodLevel: _moodLevel,
        note: note,
        tags: widget.existing!.tags,
      )));
      if (mounted) Navigator.of(context).pop();
      return;
    }

    final existingForDate = await repository.getByDate(_date);
    if (!mounted) return;

    if (existingForDate != null) {
      final replace = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('На эту дату уже есть запись'),
          content: const Text('Заменить существующую запись?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Отмена'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Заменить'),
            ),
          ],
        ),
      );

      if (replace != true) return;

      bloc.add(MoodEntryUpdated(MoodEntry(
        id: existingForDate.id,
        date: _date,
        moodLevel: _moodLevel,
        note: note,
        tags: existingForDate.tags,
      )));
    } else {
      bloc.add(MoodEntryAdded(MoodEntry(
        id: const Uuid().v4(),
        date: _date,
        moodLevel: _moodLevel,
        note: note,
        tags: const [],
      )));
    }

    if (mounted) Navigator.of(context).pop();
  }

  void _delete() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Удалить запись?'),
        content: const Text('Это действие нельзя отменить.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Отмена'),
          ),
          FilledButton(
            onPressed: () {
              context
                  .read<MoodBloc>()
                  .add(MoodEntryDeleted(widget.existing!.id));
              Navigator.of(dialogContext).pop();
              Navigator.of(context).pop();
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Редактировать' : 'Новая запись'),
        actions: [
          if (_isEditing)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: _delete,
            ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ─── Дата ───
              AppCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        DateFormatter.fullWithWeekday(_date),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // ─── Настроение ───
              AppCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Как настроение?',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 20),
                    _MoodSelector(
                      selected: _moodLevel,
                      onChanged: (level) => setState(() => _moodLevel = level),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // ─── Заметка ───
              AppCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Заметка',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _noteController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        hintText: 'Что повлияло на настроение?',
                        border: InputBorder.none,
                        filled: false,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ─── Кнопка ───
              FilledButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.check),
                label: Text(_isEditing ? 'Сохранить' : 'Добавить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MoodSelector extends StatelessWidget {
  const _MoodSelector({required this.selected, required this.onChanged});

  final MoodLevel selected;
  final ValueChanged<MoodLevel> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: MoodLevel.values.map((level) {
        final isSelected = level == selected;
        final colorScheme = Theme.of(context).colorScheme;

        return GestureDetector(
          onTap: () => onChanged(level),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? colorScheme.primaryContainer
                  : Colors.transparent,
              border: Border.all(
                color: isSelected ? colorScheme.primary : Colors.transparent,
                width: 2,
              ),
            ),
            child: MoodIcon(
              level: level,
              size: isSelected ? 44 : 36,
            ),
          ),
        );
      }).toList(),
    );
  }
}
