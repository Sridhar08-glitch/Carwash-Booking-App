import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/buttons.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(gradient: AppColors.gradientPrimary),
          ),

          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.08),

                  // Logo / brand mark
                  Text(
                    'SRIDHAR',
                    style: theme.textTheme.displaySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 6,
                    ),
                  ),
                  Text(
                    'Car Wash',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: AppColors.secondary,
                      letterSpacing: 3,
                    ),
                  ),

                  SizedBox(height: size.height * 0.06),

                  // Headline
                  Text(
                    'Premium Car Care,\nDelivered to You.',
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Book a professional car wash at our branch or anywhere you are. Shop premium detailing products. All in one app.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.white.withOpacity(0.75),
                    ),
                  ),

                  const Spacer(),

                  // CTA
                  PrimaryButton(
                    label: 'Get Started',
                    onPressed: () => context.push(AppRoutes.login),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Feature bullets
                  _Bullet(icon: Icons.verified_outlined, text: 'Certified professionals'),
                  const SizedBox(height: AppSpacing.sm),
                  _Bullet(icon: Icons.schedule_outlined, text: 'Easy slot booking'),
                  const SizedBox(height: AppSpacing.sm),
                  _Bullet(icon: Icons.shopping_bag_outlined, text: 'Premium detailing shop'),

                  SizedBox(height: AppSpacing.lg),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.secondary, size: 20),
        const SizedBox(width: AppSpacing.sm),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.white.withOpacity(0.9)),
        ),
      ],
    );
  }
}
