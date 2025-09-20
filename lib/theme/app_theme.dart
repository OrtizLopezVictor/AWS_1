import 'package:flutter/material.dart';

class AppTheme {
  static const seed = Color(0xFF6C5BD9); // morado WMS

  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: seed,
        brightness: Brightness.light,
      ),
    );

    return base.copyWith(
      // ignore: deprecated_member_use
      scaffoldBackgroundColor: base.colorScheme.surface.withOpacity(.98),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: base.colorScheme.surface,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: base.colorScheme.onSurface,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),

      // En tu SDK, ThemeData.cardTheme es CardThemeData
      cardTheme: CardThemeData(
        color: base.colorScheme.surface,
        elevation: 1,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: base.colorScheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: base.colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: base.colorScheme.primary, width: 2),
        ),
        prefixIconColor: base.colorScheme.onSurfaceVariant,
        suffixIconColor: base.colorScheme.onSurfaceVariant,
        labelStyle: TextStyle(color: base.colorScheme.onSurfaceVariant),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        shape: StadiumBorder(
          side: BorderSide(color: base.colorScheme.outlineVariant),
        ),
        labelStyle: TextStyle(color: base.colorScheme.onSurface),
      ),
    );
  }
}
