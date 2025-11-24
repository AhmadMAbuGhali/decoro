import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_fonts.dart';

class AppTextStyles {

  // ─────────────────────────── Headlines
  static const TextStyle h1 = TextStyle(
    fontFamily: AppFonts.primary,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: AppFonts.primary,
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: AppFonts.primary,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // ─────────────────────────── Body Text
  static const TextStyle body = TextStyle(
    fontFamily: AppFonts.primary,
    fontSize: 16,
    color: AppColors.textSecondary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: AppFonts.primary,
    fontSize: 14,
    color: AppColors.textSecondary,
  );

  // ─────────────────────────── Muted
  static const TextStyle muted = TextStyle(
    fontFamily: AppFonts.primary,
    fontSize: 14,
    color: AppColors.textMuted,
  );
}