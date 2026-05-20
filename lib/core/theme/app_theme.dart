import 'package:flutter/material.dart';

// Simple light theme — no fancy colors, just clean Material 3 defaults
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      // Simple card shape
      cardTheme: const CardTheme(
        elevation: 2,
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      ),
      // Clean AppBar style
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 2,
        centerTitle: false,
      ),
      // Input field underline style (Material default)
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
    );
  }
}