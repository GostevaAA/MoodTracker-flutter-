import "package:flutter/material.dart";

class MaterialThemeFiore {
  final TextTheme textTheme;

  const MaterialThemeFiore(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff904b3d),
      surfaceTint: Color(0xff904b3d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffffdad3),
      onPrimaryContainer: Color(0xff733428),
      secondary: Color(0xff775750),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffdad3),
      onSecondaryContainer: Color(0xff5d3f39),
      tertiary: Color(0xff8f4a4d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffdada),
      onTertiaryContainer: Color(0xff733337),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffff8f6),
      onSurface: Color(0xff231917),
      onSurfaceVariant: Color(0xff534340),
      outline: Color(0xff85736f),
      outlineVariant: Color(0xffd8c2bd),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff392e2c),
      inversePrimary: Color(0xffffb4a5),
      primaryFixed: Color(0xffffdad3),
      onPrimaryFixed: Color(0xff3a0a03),
      primaryFixedDim: Color(0xffffb4a5),
      onPrimaryFixedVariant: Color(0xff733428),
      secondaryFixed: Color(0xffffdad3),
      onSecondaryFixed: Color(0xff2c1510),
      secondaryFixedDim: Color(0xffe7bdb4),
      onSecondaryFixedVariant: Color(0xff5d3f39),
      tertiaryFixed: Color(0xffffdada),
      onTertiaryFixed: Color(0xff3b080f),
      tertiaryFixedDim: Color(0xffffb3b5),
      onTertiaryFixedVariant: Color(0xff733337),
      surfaceDim: Color(0xffe8d6d3),
      surfaceBright: Color(0xfffff8f6),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0ee),
      surfaceContainer: Color(0xfffceae6),
      surfaceContainerHigh: Color(0xfff7e4e1),
      surfaceContainerHighest: Color(0xfff1dfdb),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff5e2419),
      surfaceTint: Color(0xff904b3d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffa1594a),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff4b2f29),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff87655e),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff5e2327),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffa1585b),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f6),
      onSurface: Color(0xff180f0d),
      onSurfaceVariant: Color(0xff413330),
      outline: Color(0xff5f4f4b),
      outlineVariant: Color(0xff7b6965),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff392e2c),
      inversePrimary: Color(0xffffb4a5),
      primaryFixed: Color(0xffa1594a),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff844234),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff87655e),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff6d4d47),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xffa1585b),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff844044),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd4c3bf),
      surfaceBright: Color(0xfffff8f6),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0ee),
      surfaceContainer: Color(0xfff7e4e1),
      surfaceContainerHigh: Color(0xffebd9d5),
      surfaceContainerHighest: Color(0xffdfceca),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff511a10),
      surfaceTint: Color(0xff904b3d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff76362a),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff3f2520),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff60423c),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff51191e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff763539),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f6),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff372926),
      outlineVariant: Color(0xff554642),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff392e2c),
      inversePrimary: Color(0xffffb4a5),
      primaryFixed: Color(0xff76362a),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff592116),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff60423c),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff472c26),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff763539),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff591f24),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc6b5b2),
      surfaceBright: Color(0xfffff8f6),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffffede9),
      surfaceContainer: Color(0xfff1dfdb),
      surfaceContainerHigh: Color(0xffe2d1cd),
      surfaceContainerHighest: Color(0xffd4c3bf),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffb4a5),
      surfaceTint: Color(0xffffb4a5),
      onPrimary: Color(0xff561f14),
      primaryContainer: Color(0xff733428),
      onPrimaryContainer: Color(0xffffdad3),
      secondary: Color(0xffe7bdb4),
      onSecondary: Color(0xff442a24),
      secondaryContainer: Color(0xff5d3f39),
      onSecondaryContainer: Color(0xffffdad3),
      tertiary: Color(0xffffb3b5),
      onTertiary: Color(0xff561d22),
      tertiaryContainer: Color(0xff733337),
      onTertiaryContainer: Color(0xffffdada),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff1a1110),
      onSurface: Color(0xfff1dfdb),
      onSurfaceVariant: Color(0xffd8c2bd),
      outline: Color(0xffa08c88),
      outlineVariant: Color(0xff534340),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff1dfdb),
      inversePrimary: Color(0xff904b3d),
      primaryFixed: Color(0xffffdad3),
      onPrimaryFixed: Color(0xff3a0a03),
      primaryFixedDim: Color(0xffffb4a5),
      onPrimaryFixedVariant: Color(0xff733428),
      secondaryFixed: Color(0xffffdad3),
      onSecondaryFixed: Color(0xff2c1510),
      secondaryFixedDim: Color(0xffe7bdb4),
      onSecondaryFixedVariant: Color(0xff5d3f39),
      tertiaryFixed: Color(0xffffdada),
      onTertiaryFixed: Color(0xff3b080f),
      tertiaryFixedDim: Color(0xffffb3b5),
      onTertiaryFixedVariant: Color(0xff733337),
      surfaceDim: Color(0xff1a1110),
      surfaceBright: Color(0xff423734),
      surfaceContainerLowest: Color(0xff140c0b),
      surfaceContainerLow: Color(0xff231917),
      surfaceContainer: Color(0xff271d1b),
      surfaceContainerHigh: Color(0xff322826),
      surfaceContainerHighest: Color(0xff3d3230),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffd2c9),
      surfaceTint: Color(0xffffb4a5),
      onPrimary: Color(0xff48140a),
      primaryContainer: Color(0xffcc7b6b),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffed2ca),
      onSecondary: Color(0xff381f1a),
      secondaryContainer: Color(0xffae8880),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffd1d2),
      onTertiary: Color(0xff481218),
      tertiaryContainer: Color(0xffcb7a7d),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff1a1110),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffeed7d3),
      outline: Color(0xffc2ada9),
      outlineVariant: Color(0xffa08c88),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff1dfdb),
      inversePrimary: Color(0xff743529),
      primaryFixed: Color(0xffffdad3),
      onPrimaryFixed: Color(0xff2b0200),
      primaryFixedDim: Color(0xffffb4a5),
      onPrimaryFixedVariant: Color(0xff5e2419),
      secondaryFixed: Color(0xffffdad3),
      onSecondaryFixed: Color(0xff200b07),
      secondaryFixedDim: Color(0xffe7bdb4),
      onSecondaryFixedVariant: Color(0xff4b2f29),
      tertiaryFixed: Color(0xffffdada),
      onTertiaryFixed: Color(0xff2c0006),
      tertiaryFixedDim: Color(0xffffb3b5),
      onTertiaryFixedVariant: Color(0xff5e2327),
      surfaceDim: Color(0xff1a1110),
      surfaceBright: Color(0xff4e423f),
      surfaceContainerLowest: Color(0xff0d0605),
      surfaceContainerLow: Color(0xff251b19),
      surfaceContainer: Color(0xff302623),
      surfaceContainerHigh: Color(0xff3b302e),
      surfaceContainerHighest: Color(0xff463b39),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffece8),
      surfaceTint: Color(0xffffb4a5),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffffaf9e),
      onPrimaryContainer: Color(0xff200100),
      secondary: Color(0xffffece8),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffe3b9b1),
      onSecondaryContainer: Color(0xff190603),
      tertiary: Color(0xffffeceb),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffffadaf),
      onTertiaryContainer: Color(0xff220003),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff1a1110),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffffece8),
      outlineVariant: Color(0xffd4beb9),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff1dfdb),
      inversePrimary: Color(0xff743529),
      primaryFixed: Color(0xffffdad3),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffffb4a5),
      onPrimaryFixedVariant: Color(0xff2b0200),
      secondaryFixed: Color(0xffffdad3),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffe7bdb4),
      onSecondaryFixedVariant: Color(0xff200b07),
      tertiaryFixed: Color(0xffffdada),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffffb3b5),
      onTertiaryFixedVariant: Color(0xff2c0006),
      surfaceDim: Color(0xff1a1110),
      surfaceBright: Color(0xff5a4d4b),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff271d1b),
      surfaceContainer: Color(0xff392e2c),
      surfaceContainerHigh: Color(0xff443937),
      surfaceContainerHighest: Color(0xff504442),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
