import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_fonts.dart';

class AppTextStyles {
  static const TextStyle headline1 = TextStyle(
    fontFamily: AppFonts.primary,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const TextStyle bodyText1 = TextStyle(
    fontFamily: AppFonts.primary,
    fontSize: 16,
    color: AppColors.secondary,
  );
}