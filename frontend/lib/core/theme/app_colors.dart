import 'package:flutter/material.dart';

/// Single source of truth for brand colours — Sridhar Car Wash.
/// Consumed via [AppTheme] / [Theme.of(context).colorScheme].
/// For one-off branded values (promo, loyalty tiers), use the static fields.
abstract final class AppColors {
  // ─── Primary brand colour (ocean blue) ───────────────────────────────────
  static const Color primary = Color(0xFF0096C7);
  static const Color primaryVariant = Color(0xFF0077A8); // deeper shade
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFB3E5F5);
  static const Color onPrimaryContainer = Color(0xFF003647);

  // ─── Secondary / accent colour (energetic orange) ────────────────────────
  static const Color secondary = Color(0xFFFF6B35);
  static const Color secondaryVariant = Color(0xFFE84A0E); // deeper shade
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFFFDBCC);
  static const Color onSecondaryContainer = Color(0xFF5C1A00);

  // ─── Surface & background ────────────────────────────────────────────────
  static const Color surface = Color(0xFFF8FAFC);
  static const Color surfaceVariant = Color(0xFFECF5FA);
  static const Color onSurface = Color(0xFF1A1A2E);
  static const Color onSurfaceVariant = Color(0xFF4A6375);
  static const Color background = Color(0xFFF0F7FA);
  static const Color onBackground = Color(0xFF1A1A2E);

  // ─── Outline ─────────────────────────────────────────────────────────────
  static const Color outline = Color(0xFFB0C4CF);
  static const Color outlineVariant = Color(0xFFD6E8F0);

  // ─── Error ───────────────────────────────────────────────────────────────
  static const Color error = Color(0xFFD93025);
  static const Color errorRed = Color(0xFFDC2626); // legacy alias
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF410002);

  // ─── Semantic colours ────────────────────────────────────────────────────
  static const Color success = Color(0xFF2E7D32);
  static const Color onSuccess = Color(0xFFFFFFFF);
  static const Color successContainer = Color(0xFFC8E6C9);
  static const Color warning = Color(0xFFF59E0B);
  static const Color onWarning = Color(0xFFFFFFFF);
  static const Color warningContainer = Color(0xFFFEF3C7);
  static const Color info = Color(0xFF0096C7);
  static const Color onInfo = Color(0xFFFFFFFF);
  static const Color infoContainer = Color(0xFFB3E5F5);

  // ─── Promo / offers accent ───────────────────────────────────────────────
  static const Color promo = Color(0xFFEF4444); // Red urgency chip
  static const Color onPromo = Color(0xFFFFFFFF);
  static const Color promoLight = Color(0xFFFEF2F2);

  // ─── Loyalty tier colours ────────────────────────────────────────────────
  static const Color loyaltyBronze = Color(0xFFCD7F32);
  static const Color loyaltySilver = Color(0xFF9CA3AF);
  static const Color loyaltyGold = Color(0xFFF5A623);
  static const Color loyaltyPlatinum = Color(0xFF8B5CF6);

  // ─── Dark-mode overrides ─────────────────────────────────────────────────
  static const Color darkSurface = Color(0xFF0D1F2D);
  static const Color darkSurfaceVariant = Color(0xFF1A3347);
  static const Color darkOnSurface = Color(0xFFE0F4FA);
  static const Color darkOnSurfaceVariant = Color(0xFF9CA3AF);
  static const Color darkBackground = Color(0xFF071520);
  static const Color darkOnBackground = Color(0xFFE0F4FA);
  static const Color darkOutline = Color(0xFF374151);

  // ─── Gradients ───────────────────────────────────────────────────────────
  static const LinearGradient gradientPrimary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0096C7), Color(0xFF0077A8)],
  );

  static const LinearGradient gradientOcean = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0096C7), Color(0xFF005F80)],
  );

  static const LinearGradient gradientOrange = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF6B35), Color(0xFFE84A0E)],
  );

  // Backward-compatible alias (was amber → now orange)
  static const LinearGradient gradientAmber = gradientOrange;

  static const LinearGradient gradientLoyaltyGold = LinearGradient(
    colors: [Color(0xFFF5A623), Color(0xFFCD7F32)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient gradientLoyaltyPlatinum = LinearGradient(
    colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Brand gradient list — used for banners/cards
  // ignore: use_named_constants
  static const brandGradient = [Color(0xFF0096C7), Color(0xFFFF6B35)];

  // Brand gradient as LinearGradient — for widgets that accept Gradient
  static const LinearGradient brandLinearGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 1.0],
    colors: [Color(0xFF0096C7), Color(0xFFFF6B35)],
  );
}
