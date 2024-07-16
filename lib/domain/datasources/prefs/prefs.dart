import 'package:flutter/material.dart';

abstract class PreferencesDatasource {
  //IS NEW USER
  bool get newUser;
  set newUser(bool value);

  // DARK MODE
  bool get isDark;
  set isDark(bool value);

  // THEME COLOR
  Color get themeColor;
  set themeColor(Color value);

  // INSTAFEED
  bool get instafeed;
  set instafeed(bool value);
}
