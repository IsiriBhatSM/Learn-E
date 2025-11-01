// lib/providers/theme_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _key = 'is_dark_mode';
  bool _isDark = false;

  ThemeProvider() {
    _loadTheme();
  }

  bool get isDark => _isDark;

  ThemeData get theme => _isDark ? ThemeData.dark() : ThemeData.light().copyWith(
    primaryColor: const Color(0xFFFC603F),
    scaffoldBackgroundColor: _isDark ? Colors.grey[900] : Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFFFC603F),
      foregroundColor: Colors.white,
      elevation: 2,
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: _isDark ? Colors.white70 : Colors.black87),
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: _isDark ? Colors.white : Colors.black,
      ),
    ),
  );

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDark = prefs.getBool(_key) ?? false;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDark = !_isDark;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, _isDark);
    notifyListeners();
  }
}