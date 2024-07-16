import 'package:ai_tutor_quiz/presentation/providers/prefs/prefs_provider.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'color_theme_provider.g.dart';

@riverpod
class ColorTheme extends _$ColorTheme {
  @override
  Color? build() {
    return ref.read(prefsProvider).themeColor;
  }

  void changeColor(Color color) {
    state = color;
    ref.read(prefsProvider).themeColor = color;
  }
}
