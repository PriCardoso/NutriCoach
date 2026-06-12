import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {

  static ThemeData lightTheme() {

    return ThemeData(
      useMaterial3: true,

      scaffoldBackgroundColor:
          AppColors.background,

      colorScheme:
          ColorScheme.fromSeed(
        seedColor:
            AppColors.primary,
      ),

      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
        ),
        ),

      inputDecorationTheme:
          InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,

        border:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            16,
          ),
        ),
      ),
    );
  }
}