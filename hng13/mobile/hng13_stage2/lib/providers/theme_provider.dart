import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  ThemeNotifier.new,
);

class ThemeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    return ThemeMode.light;
  }

  void toggleTheme() {
    final theme = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    state = theme;
  }

  void setTheme(ThemeMode theme) {
    state = theme;
  }
}
