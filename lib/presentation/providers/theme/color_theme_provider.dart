import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'color_theme_provider.g.dart';

@riverpod
class ColorTheme extends _$ColorTheme {
  @override
  Color? build() {
    return null;
  }

  void changeColor(Color color) {
    state = color;
  }
}
