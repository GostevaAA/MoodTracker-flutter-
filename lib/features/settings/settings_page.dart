import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/theme/theme_bloc.dart';
import '../../blocs/theme/theme_event.dart';
import '../../blocs/theme/theme_state.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/theme_preset.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Настройки')),
      body: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return ListView(
            children: [
              const _SectionHeader('Тема оформления'),
              ...ThemePresetId.values.map(
                (preset) => RadioListTile<ThemePresetId>(
                  value: preset,
                  groupValue: state.preset,
                  onChanged: (value) {
                    if (value == null) return;
                    context.read<ThemeBloc>().add(ThemePresetChanged(value));
                  },
                  title: Text(preset.label),
                  secondary: _PresetPreview(preset: preset),
                ),
              ),
              const Divider(),
              const _SectionHeader('Режим яркости'),
              RadioListTile<ThemeMode>(
                value: ThemeMode.system,
                groupValue: state.mode,
                onChanged: (value) {
                  if (value == null) return;
                  context.read<ThemeBloc>().add(ThemeModeChanged(value));
                },
                title: const Text('Как в системе'),
              ),
              RadioListTile<ThemeMode>(
                value: ThemeMode.light,
                groupValue: state.mode,
                onChanged: (value) {
                  if (value == null) return;
                  context.read<ThemeBloc>().add(ThemeModeChanged(value));
                },
                title: const Text('Светлая'),
              ),
              RadioListTile<ThemeMode>(
                value: ThemeMode.dark,
                groupValue: state.mode,
                onChanged: (value) {
                  if (value == null) return;
                  context.read<ThemeBloc>().add(ThemeModeChanged(value));
                },
                title: const Text('Тёмная'),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
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

/// Круг-превью с основным цветом пресета.
class _PresetPreview extends StatelessWidget {
  const _PresetPreview({required this.preset});

  final ThemePresetId preset;

  @override
  Widget build(BuildContext context) {
    final color = AppTheme.light(preset).colorScheme.primary;

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
