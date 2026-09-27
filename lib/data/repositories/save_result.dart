import '../models/mood_entry.dart';

/// Результат попытки сохранить запись.
sealed class SaveResult {
  const SaveResult();
}

/// Запись сохранена (создана или обновлена).
class SaveSuccess extends SaveResult {
  const SaveSuccess(this.saved);
  final MoodEntry saved;
}

/// На выбранной дате уже есть другая запись.
class SaveConflict extends SaveResult {
  const SaveConflict(this.existing);
  final MoodEntry existing;
}
