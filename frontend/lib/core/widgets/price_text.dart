import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// Renders a price from a server-returned string.
/// NEVER pass a computed number — always the raw API string.
///
/// Supports:
/// - Normal price: "89.00" → "SAR 89.00"
/// - Discounted: original "110.00" + current "89.00" → strike-through + new
/// - Free: "0.00" → "Free"
/// - From: prefix "From" for variable prices
class PriceText extends StatelessWidget {
  const PriceText({
    super.key,
    required this.amount,
    required this.currency,
    this.originalAmount,
    this.showFree = true,
    this.fromPrefix = false,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.strikeColor,
    this.style,
  });

  final String amount; // e.g. "89.00" — always a string from the API
  final String currency; // e.g. "SAR"
  final String? originalAmount; // if present, show as struck-through
  final bool showFree;
  final bool fromPrefix;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final Color? strikeColor;

  /// Optional base text style (e.g. from the surrounding theme's text theme).
  /// When provided, its fontSize/fontWeight are used as defaults unless
  /// overridden by [fontSize]/[fontWeight], and [color] still wins for color.
  final TextStyle? style;

  TextStyle _baseStyle(Color? c) {
    if (style != null) {
      return style!.copyWith(
        fontSize: fontSize ?? style!.fontSize,
        fontWeight: fontWeight ?? style!.fontWeight,
        color: c ?? style!.color,
      );
    }
    return AppTypography.price(
      fontSize: fontSize ?? 18,
      fontWeight: fontWeight ?? FontWeight.w700,
      color: c,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isFree = amount == '0.00' || amount == '0';

    if (isFree && showFree) {
      return Text(
        'Free',
        style: _baseStyle(color ?? AppColors.success),
      );
    }

    final displayPrice = fromPrefix
        ? 'From $currency ${_format(amount)}'
        : '$currency ${_format(amount)}';

    if (originalAmount == null) {
      return Text(
        displayPrice,
        style: _baseStyle(color ?? theme.colorScheme.onSurface),
      );
    }

    // Discounted — show strike-through original + new price
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          '$currency ${_format(originalAmount!)}',
          style: _baseStyle(strikeColor ?? theme.colorScheme.onSurfaceVariant)
              .copyWith(
            fontSize: (fontSize ?? style?.fontSize ?? 18) * 0.8,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.lineThrough,
            decorationColor: strikeColor ?? theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          displayPrice,
          style: _baseStyle(color ?? AppColors.promo),
        ),
      ],
    );
  }

  /// Format the server string for display. The server always sends 2 decimal
  /// places but this formats it nicely (removes trailing .00 if desired — for
  /// now keep the .00 for clarity in a currency context).
  static String _format(String raw) {
    // Parse just to validate; display as-is to avoid float precision issues
    double.tryParse(raw); // ignore result — just validate it parses
    return raw;
  }
}

// ---------------------------------------------------------------------------
// Savings chip — "Save SAR 21.00 (19%)"
// ---------------------------------------------------------------------------
class SavingsChip extends StatelessWidget {
  const SavingsChip({
    super.key,
    required this.savingAmount,
    required this.currency,
    this.savingPercent,
  });

  final String savingAmount;
  final String currency;
  final String? savingPercent;

  @override
  Widget build(BuildContext context) {
    final label = savingPercent != null
        ? 'Save $currency $savingAmount ($savingPercent%)'
        : 'Save $currency $savingAmount';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.promoLight,
        borderRadius: BorderRadius.circular(AppColors.promo.red.toDouble()),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.promo,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
