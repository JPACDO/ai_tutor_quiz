import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:ai_tutor_quiz/domain/datasources/datasources.dart';

class UserPreferences extends PreferencesDatasource {
  static final UserPreferences _instancia = UserPreferences._internal();

  factory UserPreferences() {
    return _instancia;
  }

  UserPreferences._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  bool get newUser {
    return _prefs.getBool('newUser') ?? true;
  }

  @override
  set newUser(bool value) {
    _prefs.setBool('newUser', value);
  }

  // DARK MODE
  @override
  bool get isDark {
    return _prefs.getBool('isDark') ?? false;
  }

  @override
  set isDark(bool value) {
    _prefs.setBool('isDark', value);
  }

  // THEME COLOR
  @override
  Color get themeColor {
    return Color(_prefs.getInt('themeColor') ?? 0xFF2196F3B);
  }

  @override
  set themeColor(Color value) {
    _prefs.setInt('themeColor', value.value);
  }

  // INSTAFEED
  @override
  bool get instafeed {
    return _prefs.getBool('instafeed') ?? false;
  }

  @override
  set instafeed(bool value) {
    _prefs.setBool('instafeed', value);
  }
}
