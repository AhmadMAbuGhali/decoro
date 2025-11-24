import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_fonts.dart';

class AppThemes {
  // ─────────────────────────── Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: AppFonts.primary,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
      titleTextStyle: AppTextStyles.h2,
      foregroundColor: AppColors.textPrimary,
    ),

    textTheme: const TextTheme(
      // Modern Flutter names
      displayLarge: AppTextStyles.h1,
      headlineLarge: AppTextStyles.h2,
      headlineMedium: AppTextStyles.h3,
      bodyLarge: AppTextStyles.body,
      bodyMedium: AppTextStyles.bodySmall,
      labelSmall: AppTextStyles.muted,
    ),

    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.primaryLight,
      background: AppColors.background,
      surface: AppColors.surface,
      onPrimary: Colors.white,
      onBackground: AppColors.textPrimary,
    ),
  );

  // ─────────────────────────── Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: Colors.black,
    fontFamily: AppFonts.primary,

    textTheme: const TextTheme(
      displayLarge: AppTextStyles.h1,
      headlineLarge: AppTextStyles.h2,
      bodyLarge: AppTextStyles.body,
      bodyMedium: AppTextStyles.bodySmall,
    ),
  );
}