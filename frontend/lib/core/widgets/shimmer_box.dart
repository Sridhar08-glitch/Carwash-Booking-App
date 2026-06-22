import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// Shimmer placeholder box — replace content skeletons app-wide.
class ShimmerBox extends StatelessWidget {
  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  final double? width;
  final double height;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDark ? AppColors.darkSurfaceVariant : AppColors.outlineVariant,
      highlightColor: isDark ? AppColors.darkSurface : AppColors.surface,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurfaceVariant : AppColors.outlineVariant,
          borderRadius: BorderRadius.circular(borderRadius ?? AppRadius.sm),
        ),
      ),
    );
  }
}

/// Horizontal list of shimmer cards (e.g. service rail, product rail)
class ShimmerCardList extends StatelessWidget {
  const ShimmerCardList({
    super.key,
    this.itemCount = 3,
    this.cardWidth = 160,
    this.cardHeight = 120,
  });

  final int itemCount;
  final double cardWidth;
  final double cardHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: cardHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        itemCount: itemCount,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (_, __) => ShimmerBox(
          width: cardWidth,
          height: cardHeight,
          borderRadius: AppRadius.md,
        ),
      ),
    );
  }
}

/// Full-page shimmer skeleton for screens with a banner + rails layout
class HomeSkeleton extends StatelessWidget {
  const HomeSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero banner
          const ShimmerBox(width: double.infinity, height: 200),
          const SizedBox(height: AppSpacing.md),

          // Quick actions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Row(
              children: List.generate(
                4,
                (_) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ShimmerBox(
                      width: null,
                      height: 72,
                      borderRadius: AppRadius.md,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Service rail
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: ShimmerBox(width: 120, height: 20),
          ),
          const SizedBox(height: AppSpacing.sm),
          const ShimmerCardList(cardWidth: 160, cardHeight: 140),
          const SizedBox(height: AppSpacing.lg),

          // Product rail
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: ShimmerBox(width: 80, height: 20),
          ),
          const SizedBox(height: AppSpacing.sm),
          const ShimmerCardList(cardWidth: 140, cardHeight: 200),
        ],
      ),
    );
  }
}

/// List-item shimmer skeleton
class ShimmerListItem extends StatelessWidget {
  const ShimmerListItem({super.key, this.hasAvatar = true});
  final bool hasAvatar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          if (hasAvatar) ...[
            const ShimmerBox(width: 56, height: 56, borderRadius: AppRadius.md),
            const SizedBox(width: AppSpacing.md),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ShimmerBox(width: double.infinity, height: 16),
                const SizedBox(height: AppSpacing.xs),
                ShimmerBox(width: 140, height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
