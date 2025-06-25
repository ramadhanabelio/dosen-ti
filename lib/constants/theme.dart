import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryGreen = Color(0xFF2E7D32);
  static const Color primaryBlue = Color(0xFF1976D2);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
}

class AppGradients {
  static const greenGradient = LinearGradient(
    colors: [Color(0xFF43A047), Color(0xFF81C784)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.primaryGreen,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColors.primaryGreen,
      secondary: AppColors.primaryBlue,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        fontFamily: 'PlusJakartaSans',
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        fontFamily: 'PlusJakartaSans',
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: 'PlusJakartaSans',
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: 'PlusJakartaSans',
      ),
    ),
    fontFamily: 'PlusJakartaSans',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: AppColors.white,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: 'PlusJakartaSans',
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryGreen,
        backgroundColor: AppColors.white,
        side: const BorderSide(color: AppColors.primaryGreen),
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryGreen),
      ),
      labelStyle: const TextStyle(
        color: AppColors.primaryGreen,
        fontFamily: 'PlusJakartaSans',
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    ),
  );
}
