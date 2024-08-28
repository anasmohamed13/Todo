import 'package:flutter/material.dart';
import 'package:todoproject/ui/utils/app_color.dart';

abstract class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: AppColors.bgColor,
    canvasColor: AppColors.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.white,
      onPrimary: AppColors.white,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.primary,
      centerTitle: true,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.grey,
      selectedIconTheme: IconThemeData(size: 33),
      unselectedIconTheme: IconThemeData(size: 33, color: AppColors.grey),
    ),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: AppColors.bgDark,
    canvasColor: AppColors.black,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.black,
      onPrimary: AppColors.black,
    ),
    appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary, centerTitle: true),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.black,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.white,
    ),
  );
}
