import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF1F7ABC);
  static const Color accent = Color(0xFF2EC4B6);
  static const Color bg = Color(0xFFF5F7FA);
  static const Color darkBg = Color(0xFF0B1014);
}

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.teal,
    ).copyWith(secondary: AppColors.accent),
    scaffoldBackgroundColor: AppColors.bg,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
      centerTitle: true,
    ),
    cardTheme: CardThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      extendedPadding: EdgeInsets.all(12),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.darkBg,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
      centerTitle: true,
    ),
    cardTheme: CardThemeData(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}
