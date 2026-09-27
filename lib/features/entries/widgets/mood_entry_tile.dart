import 'package:flutter/material.dart';

import '../../../core/utils/date_formatter.dart';
import '../../../core/widgets/mood_icon.dart';
import '../../../data/models/mood_entry.dart';

class MoodEntryTile extends StatelessWidget {
  const MoodEntryTile({
    super.key,
    required this.entry,
    required this.onTap,
    required this.onDelete,
  });

  final MoodEntry entry;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Dismissible(
      key: ValueKey(entry.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: colorScheme.error,
        child: Icon(Icons.delete, color: colorScheme.onError),
      ),
      confirmDismiss: (_) async {
        // Возвращаем true — разрешаем удаление
        return true;
      },
      onDismissed: (_) {
        onDelete();
      },
      child: ListTile(
        leading: MoodIcon(level: entry.moodLevel),
        title: Text(entry.moodLevel.label),
        subtitle: entry.note != null && entry.note!.isNotEmpty
            ? Text(
                entry.note!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
            : Text(
                DateFormatter.shortDate(entry.date),
                style: TextStyle(color: colorScheme.onSurfaceVariant),
              ),
        trailing: Text(
          DateFormatter.shortDate(entry.date),
          style: TextStyle(
            fontSize: 12,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
