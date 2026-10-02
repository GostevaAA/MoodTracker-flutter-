import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/mood/mood_bloc.dart';
import '../../blocs/mood/mood_event.dart';
import '../../blocs/theme/theme_bloc.dart';
import '../../blocs/theme/theme_event.dart';
import '../../blocs/theme/theme_state.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/theme_preset.dart';
import '../../core/widgets/app_card.dart';
import '../../data/services/data_transfer_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _transfer = const DataTransferService();

  // ─────────────────────────────────────────────────────────────
  // Экспорт / Импорт
  // ─────────────────────────────────────────────────────────────

  Future<void> _exportData() async {
    final state = context.read<MoodBloc>().state;
    if (state.entries.isEmpty) {
      _showMessage('Нет записей для экспорта');
      return;
    }
    try {
      await _transfer.shareExport(state.entries);
    } catch (e) {
      if (mounted) _showMessage('Ошибка экспорта: $e');
    }
  }

  Future<void> _importData() async {
    try {
      final entries = await _transfer.pickAndImport();
      if (entries == null || !mounted) return;

      if (entries.isEmpty) {
        _showMessage('Файл не содержит записей');
        return;
      }

      final confirmed = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Заменить все записи?'),
          content: Text(
            'Будет загружено записей: ${entries.length}.\n'
            'Текущие записи будут удалены.',
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

      if (confirmed != true || !mounted) return;

      context.read<MoodBloc>().add(MoodEntriesImported(entries));
      _showMessage('Импортировано записей: ${entries.length}');
    } on FormatException catch (e) {
      if (mounted) _showMessage('Ошибка формата: ${e.message}');
    } catch (e) {
      if (mounted) _showMessage('Ошибка импорта: $e');
    }
  }

  void _showMessage(String text) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  // ─────────────────────────────────────────────────────────────
  // Build
  // ─────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Настройки')),
      body: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              children: [
                // ─── Тема ───
                AppCard(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const _SectionHeader('Тема оформления'),
                      ...ThemePresetId.values.map(
                        (preset) => _PresetTile(
                          preset: preset,
                          selected: preset == state.preset,
                          onTap: () => context
                              .read<ThemeBloc>()
                              .add(ThemePresetChanged(preset)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // ─── Яркость ───
                AppCard(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const _SectionHeader('Режим яркости'),
                      _ModeTile(
                        label: 'Как в системе',
                        icon: Icons.brightness_auto,
                        selected: state.mode == ThemeMode.system,
                        onTap: () => context
                            .read<ThemeBloc>()
                            .add(const ThemeModeChanged(ThemeMode.system)),
                      ),
                      _ModeTile(
                        label: 'Светлая',
                        icon: Icons.light_mode,
                        selected: state.mode == ThemeMode.light,
                        onTap: () => context
                            .read<ThemeBloc>()
                            .add(const ThemeModeChanged(ThemeMode.light)),
                      ),
                      _ModeTile(
                        label: 'Тёмная',
                        icon: Icons.dark_mode,
                        selected: state.mode == ThemeMode.dark,
                        onTap: () => context
                            .read<ThemeBloc>()
                            .add(const ThemeModeChanged(ThemeMode.dark)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // ─── Данные ───
                AppCard(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const _SectionHeader('Данные'),
                      ListTile(
                        onTap: _exportData,
                        leading: const Icon(Icons.upload_file_outlined),
                        title: const Text('Экспорт записей'),
                        subtitle: const Text('Поделиться JSON-файлом'),
                      ),
                      ListTile(
                        onTap: _importData,
                        leading: const Icon(Icons.download_outlined),
                        title: const Text('Импорт записей'),
                        subtitle: const Text('Загрузить из JSON-файла'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Вспомогательные виджеты
// ─────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class _PresetTile extends StatelessWidget {
  const _PresetTile({
    required this.preset,
    required this.selected,
    required this.onTap,
  });

  final ThemePresetId preset;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final previewColor = AppTheme.light(preset).colorScheme.primary;
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: previewColor,
        ),
      ),
      title: Text(
        preset.label,
        style: TextStyle(
          fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
      trailing: selected
          ? Icon(Icons.check_circle, color: colorScheme.primary)
          : Icon(Icons.circle_outlined, color: colorScheme.outlineVariant),
    );
  }
}

class _ModeTile extends StatelessWidget {
  const _ModeTile({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: colorScheme.onSurfaceVariant),
      title: Text(
        label,
        style: TextStyle(
          fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
      trailing: selected
          ? Icon(Icons.check_circle, color: colorScheme.primary)
          : Icon(Icons.circle_outlined, color: colorScheme.outlineVariant),
    );
  }
}
