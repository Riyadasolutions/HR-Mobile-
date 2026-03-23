import 'package:flutter/material.dart';

enum CareConnectLanguage { english, arabic }

class AppState extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  CareConnectLanguage _language = CareConnectLanguage.english;
  int _homeTabIndex = 0;

  ThemeMode get themeMode => _themeMode;
  CareConnectLanguage get language => _language;
  int get homeTabIndex => _homeTabIndex;
  bool get isArabic => _language == CareConnectLanguage.arabic;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void setTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void toggleTheme() {
    setTheme(_themeMode != ThemeMode.dark);
  }

  void setLanguage(CareConnectLanguage value) {
    _language = value;
    notifyListeners();
  }

  void selectHomeTab(int index) {
    _homeTabIndex = index;
    notifyListeners();
  }
}
