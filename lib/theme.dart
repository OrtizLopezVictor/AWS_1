
import 'package:flutter/material.dart';

class WmsTheme {
  static ThemeData get light {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0E7C86)),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
      appBarTheme: const AppBarTheme(centerTitle: true),
      chipTheme: base.chipTheme.copyWith(selectedColor: const Color(0xFF0E7C86)),
    );
  }
}
