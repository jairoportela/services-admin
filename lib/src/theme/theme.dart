import 'package:flutter/material.dart';
import 'package:services_admin/src/theme/colors.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: AppColors.primary,
    ),
    useMaterial3: true,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    buttonTheme: const ButtonThemeData(
      alignedDropdown: true,
    ),
    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    ),
  );
}
