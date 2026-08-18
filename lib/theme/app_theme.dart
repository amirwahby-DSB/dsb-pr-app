import 'package:flutter/material.dart';

/// DSBA brand tokens — derived from the official emblem
/// (Crimson sail, Golden sail, Charcoal mast) and the PR handbook palette.
class DSBAColors {
  static const Color primaryCrimson = Color(0xFFD32F2F);
  static const Color primaryCrimsonDark = Color(0xFFB71C1C);
  static const Color accentGold = Color(0xFFFBC02D);
  static const Color neutralDark = Color(0xFF212121);
  static const Color neutralLight = Color(0xFFF8F9FA);
  static const Color surfaceCard = Colors.white;
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFF9A825);
  static const Color danger = Color(0xFFC62828);
  static const Color textMuted = Color(0xFF6B6B6B);

  /// Subtle app-wide background gradient — applied once in main.dart
  /// behind every screen. Kept very light so it never fights with
  /// text or card contrast; just gives the app a bit of depth instead
  /// of a flat white/gray page.
  static const List<Color> backgroundGradient = [
    Color(0xFFFFFFFF),
    Color(0xFFF6F1E7),
  ];
}

/// Status → color mapping used across Request tracker, list chips, KPI cards.
Color statusColor(String status) {
  switch (status) {
    case 'pending':
      return DSBAColors.warning;
    case 'in_progress':
      return DSBAColors.primaryCrimson;
    case 'awaiting_info':
      return DSBAColors.accentGold;
    case 'completed':
      return DSBAColors.success;
    case 'cancelled':
      return DSBAColors.textMuted;
    default:
      return DSBAColors.textMuted;
  }
}

class AppTheme {
  static ThemeData light() {
    final base = ThemeData(useMaterial3: true, brightness: Brightness.light, fontFamily: 'Inter');
    return base.copyWith(
      // شفاف عشان الخلفية المتدرجة اللي حطيناها في main.dart تبان
      // خلف كل شاشة، بدل لون واحد مصمت.
      scaffoldBackgroundColor: Colors.transparent,
      colorScheme: base.colorScheme.copyWith(
        primary: DSBAColors.primaryCrimson,
        secondary: DSBAColors.accentGold,
        surface: DSBAColors.surfaceCard,
        onPrimary: Colors.white,
        onSecondary: DSBAColors.neutralDark,
      ),
      
      appBarTheme: const AppBarTheme(
        backgroundColor: DSBAColors.primaryCrimson,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      textTheme: base.textTheme.apply(
        bodyColor: DSBAColors.neutralDark,
        displayColor: DSBAColors.neutralDark,
      ),
      cardTheme: CardThemeData(
        color: DSBAColors.surfaceCard,
        elevation: 3,
        shadowColor: Colors.black.withValues(alpha: 0.10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: DSBAColors.primaryCrimson,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: DSBAColors.primaryCrimson, width: 1.5),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: DSBAColors.primaryCrimson,
        unselectedItemColor: DSBAColors.textMuted,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      tabBarTheme: const TabBarThemeData(
        labelColor: DSBAColors.primaryCrimson,
        unselectedLabelColor: DSBAColors.textMuted,
        indicatorColor: DSBAColors.accentGold,
        indicatorSize: TabBarIndicatorSize.label,
      ),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: DSBAColors.neutralLight,
        labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
