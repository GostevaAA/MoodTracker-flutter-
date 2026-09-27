/// Идентификаторы доступных пресетов тем.
/// Хранятся в shared_preferences как строка.
enum ThemePresetId {
  claren('claren', 'Claren'),
  fiore('fiore', 'Fiore');

  const ThemePresetId(this.storageKey, this.label);

  /// Ключ для сохранения в настройках.
  final String storageKey;

  /// Человекочитаемое название.
  final String label;

  static ThemePresetId fromStorage(String? key) {
    if (key == null) return ThemePresetId.claren;
    return ThemePresetId.values.firstWhere(
      (p) => p.storageKey == key,
      orElse: () => ThemePresetId.claren,
    );
  }
}
