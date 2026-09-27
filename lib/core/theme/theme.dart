import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff715188),
      surfaceTint: Color(0xff715188),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xfff3daff),
      onPrimaryContainer: Color(0xff583a6f),
      secondary: Color(0xff675a6e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffeedcf5),
      onSecondaryContainer: Color(0xff4f4256),
      tertiary: Color(0xff5f5791),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffe5deff),
      onTertiaryContainer: Color(0xff473f77),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffff7fd),
      onSurface: Color(0xff1e1a20),
      onSurfaceVariant: Color(0xff4b454d),
      outline: Color(0xff7c757e),
      outlineVariant: Color(0xffcdc3ce),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff332f35),
      inversePrimary: Color(0xffdeb8f7),
      primaryFixed: Color(0xfff3daff),
      onPrimaryFixed: Color(0xff2a0c40),
      primaryFixedDim: Color(0xffdeb8f7),
      onPrimaryFixedVariant: Color(0xff583a6f),
      secondaryFixed: Color(0xffeedcf5),
      onSecondaryFixed: Color(0xff221729),
      secondaryFixedDim: Color(0xffd2c1d9),
      onSecondaryFixedVariant: Color(0xff4f4256),
      tertiaryFixed: Color(0xffe5deff),
      onTertiaryFixed: Color(0xff1b1149),
      tertiaryFixedDim: Color(0xffc8bfff),
      onTertiaryFixedVariant: Color(0xff473f77),
      surfaceDim: Color(0xffe0d7df),
      surfaceBright: Color(0xfffff7fd),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffaf1f9),
      surfaceContainer: Color(0xfff4ebf3),
      surfaceContainerHigh: Color(0xffeee6ed),
      surfaceContainerHighest: Color(0xffe9e0e8),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff47295d),
      surfaceTint: Color(0xff715188),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff816098),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff3d3245),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff76687d),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff362e65),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff6e66a0),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff7fd),
      onSurface: Color(0xff131015),
      onSurfaceVariant: Color(0xff3a343c),
      outline: Color(0xff575059),
      outlineVariant: Color(0xff726b74),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff332f35),
      inversePrimary: Color(0xffdeb8f7),
      primaryFixed: Color(0xff816098),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff67487e),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff76687d),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff5d5064),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff6e66a0),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff554d86),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffccc4cc),
      surfaceBright: Color(0xfffff7fd),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffaf1f9),
      surfaceContainer: Color(0xffeee6ed),
      surfaceContainerHigh: Color(0xffe3dae2),
      surfaceContainerHighest: Color(0xffd7cfd7),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff3c1e52),
      surfaceTint: Color(0xff715188),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff5b3c71),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff33283a),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff514558),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff2c245a),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff49417a),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff7fd),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff302a32),
      outlineVariant: Color(0xff4d4750),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff332f35),
      inversePrimary: Color(0xffdeb8f7),
      primaryFixed: Color(0xff5b3c71),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff432559),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff514558),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff3a2e41),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff49417a),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff332b61),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffbeb6be),
      surfaceBright: Color(0xfffff7fd),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff7eef6),
      surfaceContainer: Color(0xffe9e0e8),
      surfaceContainerHigh: Color(0xffdad2da),
      surfaceContainerHighest: Color(0xffccc4cc),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffdeb8f7),
      surfaceTint: Color(0xffdeb8f7),
      onPrimary: Color(0xff412357),
      primaryContainer: Color(0xff583a6f),
      onPrimaryContainer: Color(0xfff3daff),
      secondary: Color(0xffd2c1d9),
      onSecondary: Color(0xff372c3f),
      secondaryContainer: Color(0xff4f4256),
      onSecondaryContainer: Color(0xffeedcf5),
      tertiary: Color(0xffc8bfff),
      onTertiary: Color(0xff30285f),
      tertiaryContainer: Color(0xff473f77),
      onTertiaryContainer: Color(0xffe5deff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff161217),
      onSurface: Color(0xffe9e0e8),
      onSurfaceVariant: Color(0xffcdc3ce),
      outline: Color(0xff968e98),
      outlineVariant: Color(0xff4b454d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe9e0e8),
      inversePrimary: Color(0xff715188),
      primaryFixed: Color(0xfff3daff),
      onPrimaryFixed: Color(0xff2a0c40),
      primaryFixedDim: Color(0xffdeb8f7),
      onPrimaryFixedVariant: Color(0xff583a6f),
      secondaryFixed: Color(0xffeedcf5),
      onSecondaryFixed: Color(0xff221729),
      secondaryFixedDim: Color(0xffd2c1d9),
      onSecondaryFixedVariant: Color(0xff4f4256),
      tertiaryFixed: Color(0xffe5deff),
      onTertiaryFixed: Color(0xff1b1149),
      tertiaryFixedDim: Color(0xffc8bfff),
      onTertiaryFixedVariant: Color(0xff473f77),
      surfaceDim: Color(0xff161217),
      surfaceBright: Color(0xff3c383e),
      surfaceContainerLowest: Color(0xff100d12),
      surfaceContainerLow: Color(0xff1e1a20),
      surfaceContainer: Color(0xff221e24),
      surfaceContainerHigh: Color(0xff2d292e),
      surfaceContainerHighest: Color(0xff383339),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffefd2ff),
      surfaceTint: Color(0xffdeb8f7),
      onPrimary: Color(0xff35174b),
      primaryContainer: Color(0xffa683be),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffe8d6ef),
      onSecondary: Color(0xff2c2133),
      secondaryContainer: Color(0xff9b8ba2),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffdfd7ff),
      onTertiary: Color(0xff251d53),
      tertiaryContainer: Color(0xff9289c7),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff161217),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffe3d9e4),
      outline: Color(0xffb8afb9),
      outlineVariant: Color(0xff968e98),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe9e0e8),
      inversePrimary: Color(0xff5a3b70),
      primaryFixed: Color(0xfff3daff),
      onPrimaryFixed: Color(0xff1f0135),
      primaryFixedDim: Color(0xffdeb8f7),
      onPrimaryFixedVariant: Color(0xff47295d),
      secondaryFixed: Color(0xffeedcf5),
      onSecondaryFixed: Color(0xff170d1e),
      secondaryFixedDim: Color(0xffd2c1d9),
      onSecondaryFixedVariant: Color(0xff3d3245),
      tertiaryFixed: Color(0xffe5deff),
      onTertiaryFixed: Color(0xff10043f),
      tertiaryFixedDim: Color(0xffc8bfff),
      onTertiaryFixedVariant: Color(0xff362e65),
      surfaceDim: Color(0xff161217),
      surfaceBright: Color(0xff484349),
      surfaceContainerLowest: Color(0xff09060b),
      surfaceContainerLow: Color(0xff201c22),
      surfaceContainer: Color(0xff2b262c),
      surfaceContainerHigh: Color(0xff353137),
      surfaceContainerHighest: Color(0xff413c42),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffbebff),
      surfaceTint: Color(0xffdeb8f7),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffdab4f3),
      onPrimaryContainer: Color(0xff170029),
      secondary: Color(0xfffbebff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffcebdd5),
      onSecondaryContainer: Color(0xff110718),
      tertiary: Color(0xfff3edff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffc5bbfc),
      onTertiaryContainer: Color(0xff0a0037),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff161217),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xfff7edf8),
      outlineVariant: Color(0xffc9c0ca),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe9e0e8),
      inversePrimary: Color(0xff5a3b70),
      primaryFixed: Color(0xfff3daff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffdeb8f7),
      onPrimaryFixedVariant: Color(0xff1f0135),
      secondaryFixed: Color(0xffeedcf5),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffd2c1d9),
      onSecondaryFixedVariant: Color(0xff170d1e),
      tertiaryFixed: Color(0xffe5deff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffc8bfff),
      onTertiaryFixedVariant: Color(0xff10043f),
      surfaceDim: Color(0xff161217),
      surfaceBright: Color(0xff544e55),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff221e24),
      surfaceContainer: Color(0xff332f35),
      surfaceContainerHigh: Color(0xff3e3a40),
      surfaceContainerHighest: Color(0xff4a454b),
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


  List<ExtendedColor> get extendedColors => [
  ];
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
