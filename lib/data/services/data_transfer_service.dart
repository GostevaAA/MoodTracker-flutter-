import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/constants/mood_level.dart';
import '../../core/utils/date_utils.dart' as date_utils;
import '../models/mood_entry.dart';

/// Сервис для экспорта и импорта записей в JSON.
class DataTransferService {
  const DataTransferService();

  // ─────────────────────────────────────────────────────────────
  // Экспорт
  // ─────────────────────────────────────────────────────────────

  /// Формирует JSON-строку со всеми записями.
  String exportToJson(List<MoodEntry> entries) {
    final data = {
      'version': 1,
      'exportedAt': DateTime.now().toIso8601String(),
      'entries': entries.map(_entryToJson).toList(),
    };
    return const JsonEncoder.withIndent('  ').convert(data);
  }

  /// Открывает системный share-диалог с JSON-файлом.
  Future<void> shareExport(List<MoodEntry> entries) async {
    final json = exportToJson(entries);
    final bytes = utf8.encode(json);
    final fileName = 'mood_tracker_${_fileDateStamp()}.json';

    await SharePlus.instance.share(
      ShareParams(
        files: [
          XFile.fromData(
            bytes,
            mimeType: 'application/json',
          ),
        ],
        fileNameOverrides: [fileName],
        subject: 'Mood Tracker export',
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // Импорт
  // ─────────────────────────────────────────────────────────────

  /// Открывает выбор файла и возвращает список записей,
  /// или null, если пользователь отменил.
  /// Бросает [FormatException], если файл некорректный.
  Future<List<MoodEntry>?> pickAndImport() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result == null || result.isEmpty) return null;

    final file = result.first;
    final bytes = await file.readAsBytes();
    if (bytes == null) {
      throw const FormatException('Не удалось прочитать файл');
    }

    final content = utf8.decode(bytes);
    return parseImport(content);
  }

  /// Парсит JSON-строку и возвращает список записей.
  /// Бросает [FormatException], если структура некорректная.
  List<MoodEntry> parseImport(String jsonString) {
    final dynamic decoded;
    try {
      decoded = jsonDecode(jsonString);
    } catch (_) {
      throw const FormatException('Файл не является корректным JSON');
    }

    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Ожидался объект с полем "entries"');
    }

    final entriesRaw = decoded['entries'];
    if (entriesRaw is! List) {
      throw const FormatException('Поле "entries" отсутствует или не список');
    }

    final result = <MoodEntry>[];
    for (var i = 0; i < entriesRaw.length; i++) {
      try {
        final map = entriesRaw[i] as Map<String, dynamic>;
        result.add(_entryFromJson(map));
      } catch (e) {
        throw FormatException('Ошибка в записи №${i + 1}: $e');
      }
    }
    return result;
  }

  // ─────────────────────────────────────────────────────────────
  // Сериализация одной записи
  // ─────────────────────────────────────────────────────────────

  Map<String, dynamic> _entryToJson(MoodEntry entry) {
    return {
      'id': entry.id,
      'date': date_utils.dateOnly(entry.date).toIso8601String(),
      'moodLevel': entry.moodLevel.value,
      'note': entry.note,
      'tags': entry.tags,
    };
  }

  MoodEntry _entryFromJson(Map<String, dynamic> map) {
    final id = map['id'] as String?;
    final dateRaw = map['date'] as String?;
    final moodRaw = map['moodLevel'] as int?;

    if (id == null || id.isEmpty) {
      throw const FormatException('Отсутствует id');
    }
    if (dateRaw == null) {
      throw const FormatException('Отсутствует date');
    }
    if (moodRaw == null || moodRaw < 1 || moodRaw > 5) {
      throw const FormatException('Некорректный moodLevel');
    }

    return MoodEntry(
      id: id,
      date: DateTime.parse(dateRaw),
      moodLevel: MoodLevel.fromValue(moodRaw),
      note: map['note'] as String?,
      tags: (map['tags'] as List?)?.cast<String>() ?? const [],
    );
  }

  String _fileDateStamp() {
    final now = DateTime.now();
    return '${now.year}${_two(now.month)}${_two(now.day)}';
  }

  String _two(int n) => n.toString().padLeft(2, '0');
}
