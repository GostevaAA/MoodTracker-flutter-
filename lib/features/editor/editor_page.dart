import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../blocs/mood/mood_bloc.dart';
import '../../blocs/mood/mood_event.dart';
import '../../core/constants/mood_level.dart';
import '../../core/utils/date_utils.dart' as date_utils;
import '../../core/widgets/mood_icon.dart';
import '../../data/models/mood_entry.dart';
import '../../data/repositories/mood_repository.dart';

class EditorPage extends StatefulWidget {
  const EditorPage({super.key, this.existing, this.initialDate});

  /// Если передана — редактируем. Если null — создаём новую.
  final MoodEntry? existing;

  /// Дата, на которую создаётся запись (если existing == null).
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

    // Создание новой — проверяем, нет ли уже записи на эту дату
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
            TextButton(
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
          TextButton(
            onPressed: () {
              context
                  .read<MoodBloc>()
                  .add(MoodEntryDeleted(widget.existing!.id));
              Navigator.of(dialogContext).pop();
              Navigator.of(context).pop();
            },
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Как настроение?', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            _MoodSelector(
              selected: _moodLevel,
              onChanged: (level) => setState(() => _moodLevel = level),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _noteController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Заметка (необязательно)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.check),
              label: Text(_isEditing ? 'Сохранить' : 'Добавить'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Горизонтальный ряд иконок настроения для выбора.
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
        return GestureDetector(
          onTap: () => onChanged(level),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Colors.transparent,
              border: Border.all(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
                width: 2,
              ),
            ),
            child: MoodIcon(level: level, size: 40),
          ),
        );
      }).toList(),
    );
  }
}
