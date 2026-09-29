import 'package:flutter/material.dart';

/// Definisi palet warna standar aplikasi (Design System)
class AppColors {
  AppColors._();

  // Warna Utama (Primary & Brand)
  static const Color primary = Color(0xFF2563EB); // Royal Blue Modern
  static const Color primaryDark = Color(0xFF1D4ED8);
  static const Color primaryLight = Color(0xFF60A5FA);
  static const Color primarySoft = Color(0xFFEFF6FF);

  // Warna Sekunder & Aksen
  static const Color secondary = Color(0xFF0F172A); // Slate Dark
  static const Color accent = Color(0xFF38BDF8);

  // Background & Surface
  static const Color background = Color(0xFFF8FAFC); // Slate 50
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardBg = Color(0xFFFFFFFF);

  // Teks
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color textWhite = Color(0xFFFFFFFF);

  // Border & Garis
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderFocused = Color(0xFF2563EB);

  // State & Feedback
  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
}
