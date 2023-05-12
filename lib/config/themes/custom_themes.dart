import 'package:bubble/config/themes/themes.dart';
import 'package:flutter/material.dart';

class CustomThemes {
  static ThemeData light = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.white,
      actionsIconTheme: IconThemeData(
        size: 20,
        color: AppColors.black,
      ),
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.theme,
      onPrimary: AppColors.themeLight,
      secondary: AppColors.black,
      onSecondary: AppColors.white,
      error: AppColors.error,
      onError: AppColors.white,
      background: AppColors.themeLight,
      onBackground: AppColors.lightBlack,
      surface: AppColors.grey,
      onSurface: AppColors.lightBlack,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        letterSpacing: 1.1,
        color: AppColors.black,
        fontSize: AppFontSize.titleLarge,
      ),
      titleMedium: TextStyle(
        letterSpacing: 1.1,
        color: AppColors.black,
        fontSize: AppFontSize.titleMedium,
      ),
      titleSmall: TextStyle(
        letterSpacing: 1.1,
        color: AppColors.black,
        fontSize: AppFontSize.titleSmall,
      ),
      bodyLarge: TextStyle(
        letterSpacing: 1.1,
        color: AppColors.black,
        fontSize: AppFontSize.bodyLarge,
      ),
      bodyMedium: TextStyle(
        letterSpacing: 1.1,
        color: AppColors.black,
        fontSize: AppFontSize.bodyMedium,
      ),
      bodySmall: TextStyle(
        letterSpacing: 1.1,
        color: AppColors.lightBlack,
        fontSize: AppFontSize.bodySmall,
      ),
      displayLarge: TextStyle(
        letterSpacing: 1.1,
        color: AppColors.grey,
        fontSize: AppFontSize.displayLarge,
      ),
      displayMedium: TextStyle(
        letterSpacing: 1.1,
        color: AppColors.grey,
        fontSize: AppFontSize.displayMedium,
      ),
      displaySmall: TextStyle(
        letterSpacing: 1.1,
        color: AppColors.grey,
        fontSize: AppFontSize.displaySmall,
      ),
    ),
  );

  static ThemeData dark = ThemeData(
    scaffoldBackgroundColor: AppColors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.black,
      elevation: 0,
      actionsIconTheme: IconThemeData(
        size: 20,
        color: AppColors.white,
      ),
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.theme,
      onPrimary: AppColors.themeLight,
      secondary: AppColors.white,
      onSecondary: AppColors.black,
      error: AppColors.error,
      onError: AppColors.lightBlack,
      background: AppColors.lightBlack,
      onBackground: AppColors.grey,
      surface: AppColors.lightBlack,
      onSurface: AppColors.grey,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        letterSpacing: 1.1,
        color: AppColors.white,
        fontSize: AppFontSize.titleLarge,
      ),
      titleMedium: TextStyle(
        letterSpacing: 1.1,
        color: AppColors.white,
        fontSize: AppFontSize.titleMedium,
      ),
      titleSmall: TextStyle(
        letterSpacing: 1.1,
        color: AppColors.white,
        fontSize: AppFontSize.titleSmall,
      ),
      bodyLarge: TextStyle(
        letterSpacing: 1.1,
        color: AppColors.white,
        fontSize: AppFontSize.bodyLarge,
      ),
      bodyMedium: TextStyle(
        letterSpacing: 1.1,
        color: AppColors.white,
        fontSize: AppFontSize.bodyMedium,
      ),
      bodySmall: TextStyle(
        letterSpacing: 1.1,
        color: AppColors.grey,
        fontSize: AppFontSize.bodySmall,
      ),
      displayLarge: TextStyle(
        letterSpacing: 1.1,
        color: AppColors.grey,
        fontSize: AppFontSize.displayLarge,
      ),
      displayMedium: TextStyle(
        letterSpacing: 1.1,
        color: AppColors.grey,
        fontSize: AppFontSize.displayMedium,
      ),
      displaySmall: TextStyle(
        letterSpacing: 1.1,
        color: AppColors.grey,
        fontSize: AppFontSize.displaySmall,
      ),
    ),
  );
}
