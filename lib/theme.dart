import 'dart:ui';

import 'package:clashofclanstracker/utils/UserSP.dart';
import 'package:color_hex/color_hex.dart';
import 'package:flutter/material.dart';

class CoCTrackerThemes {
  final Color colorSeed;

  const CoCTrackerThemes({required this.colorSeed});

  ThemeData createBaseTheme({
    required Brightness brightness,
    required Color colorSeed,
    Color? backgroundColor1,
    Color? backgroundColor2,
    Color? container1,
    Color? container2,
    Color? textColor,
    Color? textColor2
  }) {
    ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: colorSeed,
      brightness: brightness,
      //background colors
      primary: backgroundColor1,
      secondary: backgroundColor2,

      //accent color
      tertiary: colorSeed,

      //container colors
      surfaceContainer: container1,
      secondaryContainer: container2,

      //text colors
      surface: textColor,
      onSurface: textColor2
    );

    return ThemeData(
      fontFamily: 'Inter',
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: Colors.transparent,
      textTheme: const TextTheme(
        displaySmall: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        headlineLarge: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          fontSize: 25,
        ),
        titleMedium: TextStyle(
          fontSize: 20,
        ),
        titleSmall: TextStyle(
          fontSize: 12,
        ),
        labelLarge: TextStyle(
          fontSize: 15
        )
      )
    );
  }

  ThemeData get light {
    ThemeData theme = createBaseTheme(
      brightness: Brightness.light,
      colorSeed: colorSeed,
      backgroundColor1: Color(0xFFDBDBFF),
      backgroundColor2: Color(0xFFE0F4FF),
      container1: Colors.white.withValues(alpha: 0.8),
      container2: Colors.white.withValues(alpha: 0.6),
      textColor: Colors.black,
      textColor2: Colors.black87
    );

    return theme;
  }

  ThemeData get dark {
    final theme = createBaseTheme(
      brightness: Brightness.dark,
      colorSeed: colorSeed,
      backgroundColor1: Color(0xFF09090B),
      backgroundColor2: Color(0xFF0E1011),
      container1: Colors.black.withValues(alpha: 0.8),
      container2: Colors.black.withValues(alpha: 0.6),
      textColor: Colors.white,
      textColor2: Colors.white54
    );

    return theme;
  }
}

enum ThemeType {light, dark}

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = UserSP.getDarkTheme()? CoCTrackerThemes(colorSeed: UserSP.getAccentColor().convertToColor).dark : CoCTrackerThemes(colorSeed: UserSP.getAccentColor().convertToColor).light;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void setTheme(bool dark, Color color) {
    if(dark) {
      themeData = CoCTrackerThemes(colorSeed: color).dark;
    } else {
      themeData = CoCTrackerThemes(colorSeed: color).light;
    }
  }
}