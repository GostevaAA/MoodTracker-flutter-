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
  late Set<String> _selectedTags;

  bool get _isEditing => widget.existing != null;

  static const _availableTags = <String>[
    'Работа',
    'Учёба',
    'Спорт',
    'Семья',
    'Друзья',
    'Отдых',
    'Сон',
    'Здоровье',
    'Погода',
    'Хобби',
  ];

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _moodLevel = existing?.moodLevel ?? MoodLevel.okay;
    _date = existing?.date ?? widget.initialDate ?? date_utils.today;
    _noteController = TextEditingController(text: existing?.note ?? '');
    _selectedTags = {...(existing?.tags ?? const <String>[])};
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      locale: const Locale('ru'),
    );
    if (picked == null) return;
    setState(() => _date = date_utils.dateOnly(picked));
  }

  void _toggleTag(String tag) {
    setState(() {
      if (_selectedTags.contains(tag)) {
        _selectedTags.remove(tag);
      } else {
        _selectedTags.add(tag);
      }
    });
  }

  Future<void> _save() async {
    final repository = context.read<MoodRepository>();
    final bloc = context.read<MoodBloc>();

    final entry = _buildEntry();

    // Проверяем конфликт: на дате уже есть другая запись?
    final existing = await repository.getByDate(entry.date);
    if (!mounted) return;

    final hasConflict = existing != null && existing.id != entry.id;

    if (hasConflict) {
      final replace = await _askReplace(existing);
      if (replace != true) return;

      // Заменяем конфликтную запись в БД до отправки в Bloc,
      // чтобы Bloc при saveEntry не наткнулся на неё снова.
      await repository.replaceEntry(entry, existing);
    }

    // Bloc сохраняет запись (в случае replaceEntry она уже в БД,
    // но повторный put перезапишет тем же — не страшно).
    bloc.add(_isEditing ? MoodEntryUpdated(entry) : MoodEntryAdded(entry));
    if (mounted) Navigator.of(context).pop();
  }

  /// Собирает MoodEntry из текущего состояния формы.
  MoodEntry _buildEntry() {
    final noteText = _noteController.text.trim();
    return MoodEntry(
      id: widget.existing?.id ?? const Uuid().v4(),
      date: _date,
      moodLevel: _moodLevel,
      note: noteText.isEmpty ? null : noteText,
      tags: _selectedTags.toList(),
    );
  }

  Future<bool?> _askReplace(MoodEntry conflict) {
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('На эту дату уже есть запись'),
        content: Text(
          'Заменить запись от '
          '${DateFormatter.shortDate(conflict.date)}?',
        ),
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
              _DateCard(date: _date, onTap: _pickDate),
              const SizedBox(height: 16),
              _MoodCard(
                moodLevel: _moodLevel,
                onChanged: (level) => setState(() => _moodLevel = level),
              ),
              const SizedBox(height: 16),
              _TagsCard(
                availableTags: _availableTags,
                selectedTags: _selectedTags,
                onToggle: _toggleTag,
              ),
              const SizedBox(height: 16),
              _NoteCard(controller: _noteController),
              const SizedBox(height: 24),
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

// ─────────────────────────────────────────────────────────────
// Приватные виджеты
// ─────────────────────────────────────────────────────────────

class _DateCard extends StatelessWidget {
  const _DateCard({required this.date, required this.onTap});

  final DateTime date;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                DateFormatter.fullWithWeekday(date),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Icon(
              Icons.edit_outlined,
              size: 20,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}

class _MoodCard extends StatelessWidget {
  const _MoodCard({required this.moodLevel, required this.onChanged});

  final MoodLevel moodLevel;
  final ValueChanged<MoodLevel> onChanged;

  @override
  Widget build(BuildContext context) {
    return AppCard(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: MoodLevel.values
                .map((level) => _MoodButton(
                      level: level,
                      selected: level == moodLevel,
                      onTap: () => onChanged(level),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _MoodButton extends StatelessWidget {
  const _MoodButton({
    required this.level,
    required this.selected,
    required this.onTap,
  });

  final MoodLevel level;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected ? colorScheme.primaryContainer : Colors.transparent,
          border: Border.all(
            color: selected ? colorScheme.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: MoodIcon(level: level, size: selected ? 44 : 36),
      ),
    );
  }
}

class _TagsCard extends StatelessWidget {
  const _TagsCard({
    required this.availableTags,
    required this.selectedTags,
    required this.onToggle,
  });

  final List<String> availableTags;
  final Set<String> selectedTags;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Что повлияло?',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'Выбери один или несколько факторов',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: availableTags.map((tag) {
              final selected = selectedTags.contains(tag);
              return FilterChip(
                label: Text(tag),
                selected: selected,
                onSelected: (_) => onToggle(tag),
                checkmarkColor: colorScheme.onSecondaryContainer,
                selectedColor: colorScheme.secondaryContainer,
                labelStyle: TextStyle(
                  color: selected
                      ? colorScheme.onSecondaryContainer
                      : colorScheme.onSurface,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _NoteCard extends StatelessWidget {
  const _NoteCard({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return AppCard(
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
            controller: controller,
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
    );
  }
}
