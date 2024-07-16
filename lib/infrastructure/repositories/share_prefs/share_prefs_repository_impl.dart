import 'dart:ui';

import 'package:ai_tutor_quiz/domain/repositories/repositories.dart';
import 'package:ai_tutor_quiz/infrastructure/datasources/datasources.dart';

class PrefsRepositoryImpl implements PreferencesRepository {
  final UserPreferences _preferences;

  PrefsRepositoryImpl(this._preferences);

  //IS NEW USER
  @override
  bool get newUser {
    return _preferences.newUser;
  }

  @override
  set newUser(bool value) {
    _preferences.newUser = value;
  }

  // DARK MODE
  @override
  bool get isDark {
    return _preferences.isDark;
  }

  @override
  set isDark(bool value) {
    _preferences.isDark = value;
  }

  // THEME COLOR
  @override
  Color get themeColor {
    return _preferences.themeColor;
  }

  @override
  set themeColor(Color value) {
    _preferences.themeColor = value;
  }

  // INSTAFEED
  @override
  bool get instafeed {
    return _preferences.instafeed;
  }

  @override
  set instafeed(bool value) {
    _preferences.instafeed = value;
  }
}
