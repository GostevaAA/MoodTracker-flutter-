import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/theme/theme_bloc.dart';
import '../../blocs/theme/theme_event.dart';
import '../../blocs/theme/theme_state.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/theme_preset.dart';
import '../../core/widgets/app_card.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
                        value: ThemeMode.system,
                        selected: state.mode == ThemeMode.system,
                        onTap: () => context
                            .read<ThemeBloc>()
                            .add(const ThemeModeChanged(ThemeMode.system)),
                      ),
                      _ModeTile(
                        label: 'Светлая',
                        icon: Icons.light_mode,
                        value: ThemeMode.light,
                        selected: state.mode == ThemeMode.light,
                        onTap: () => context
                            .read<ThemeBloc>()
                            .add(const ThemeModeChanged(ThemeMode.light)),
                      ),
                      _ModeTile(
                        label: 'Тёмная',
                        icon: Icons.dark_mode,
                        value: ThemeMode.dark,
                        selected: state.mode == ThemeMode.dark,
                        onTap: () => context
                            .read<ThemeBloc>()
                            .add(const ThemeModeChanged(ThemeMode.dark)),
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
    required this.value,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final ThemeMode value;
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
