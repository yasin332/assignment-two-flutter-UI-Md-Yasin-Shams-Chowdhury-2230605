import 'package:flutter/material.dart';

class AppPalette {
  const AppPalette._();

  static const blue = Color(0xFF2F6BFF);
  static const blueDeep = Color(0xFF1E4ED8);
  static const highBackground = Color(0xFFFDECEE);
  static const highForeground = Color(0xFFE25B6A);
  static const mediumBackground = Color(0xFFFFF3D6);
  static const mediumForeground = Color(0xFFE09A12);
  static const lowBackground = Color(0xFFE5F8EE);
  static const lowForeground = Color(0xFF2FA36A);
  static const danger = Color(0xFFE5484D);
}

class AppColors {
  const AppColors({
    required this.background,
    required this.card,
    required this.ink,
    required this.muted,
    required this.line,
    required this.blueSoft,
    required this.searchFill,
    required this.classBlue,
    required this.classGreen,
    required this.track,
    required this.shadow,
  });

  final Color background;
  final Color card;
  final Color ink;
  final Color muted;
  final Color line;
  final Color blueSoft;
  final Color searchFill;
  final Color classBlue;
  final Color classGreen;
  final Color track;
  final Color shadow;

  static const light = AppColors(
    background: Color(0xFFF5F7FB),
    card: Colors.white,
    ink: Color(0xFF1C2434),
    muted: Color(0xFF8B93A7),
    line: Color(0xFFE6EAF2),
    blueSoft: Color(0xFFE7F0FF),
    searchFill: Color(0xFFF0F3F8),
    classBlue: Color(0xFFE7F1FF),
    classGreen: Color(0xFFE7F8EF),
    track: Color(0xFFE6EAF2),
    shadow: Color(0x140F172A),
  );

  static const dark = AppColors(
    background: Color(0xFF0F1420),
    card: Color(0xFF1A2130),
    ink: Color(0xFFF4F7FB),
    muted: Color(0xFF9AA3B5),
    line: Color(0xFF2A3346),
    blueSoft: Color(0xFF1E2C4A),
    searchFill: Color(0xFF151B28),
    classBlue: Color(0xFF1A2A44),
    classGreen: Color(0xFF163028),
    track: Color(0xFF2A3346),
    shadow: Color(0x00000000),
  );

  static AppColors of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? dark : light;
  }

  List<BoxShadow> get cardShadow => [
    BoxShadow(color: shadow, blurRadius: 18, offset: const Offset(0, 8)),
  ];
}
