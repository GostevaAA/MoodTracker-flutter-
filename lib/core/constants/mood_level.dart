enum MoodLevel {
  awful(1, 'Ужасно'),
  bad(2, 'Плохо'),
  okay(3, 'Нормально'),
  good(4, 'Хорошо'),
  great(5, 'Отлично');

  const MoodLevel(this.value, this.label);

  final int value;
  final String label;

  static MoodLevel fromValue(int value) {
    return MoodLevel.values.firstWhere(
      (level) => level.value == value,
      orElse: () => MoodLevel.okay,
    );
  }
}
