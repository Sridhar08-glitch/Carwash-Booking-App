/// 4-pt spacing system. Use these everywhere — never raw numbers.
abstract class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;

  static const double pagePadding = md;
  static const double sectionGap = lg;
  static const double cardPadding = md;
  static const double itemGap = sm;
}

/// 4-pt border radius system.
abstract class AppRadius {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 20;
  static const double pill = 999;
}
