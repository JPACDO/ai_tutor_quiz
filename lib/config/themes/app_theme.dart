import 'package:flutter/material.dart';

class AppTheme {
  final bool isDarkmode;
  final Color? seedColor;

  AppTheme({required this.isDarkmode, this.seedColor});

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: seedColor,
        brightness: isDarkmode ? Brightness.dark : Brightness.light,
        listTileTheme: ListTileThemeData(
          iconColor: seedColor,
        ),
      );
}
