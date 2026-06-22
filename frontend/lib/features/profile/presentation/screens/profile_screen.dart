import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/auth/session_controller.dart';
import '../../../../core/providers/session_provider.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../auth/data/auth_repository.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionStateProvider);
    final user = session.maybeWhen(
      authenticated: (u, _, __) => u,
      orElse: () => null,
    );
    final themeMode = ref.watch(themeModeProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // Avatar + user info
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.primary,
                  child: Text(
                    user?.phone.substring(user.phone.length - 2) ?? 'U',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  user?.phone ?? '—',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (user?.email != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    user!.email!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Text(
                    user?.role.name.toUpperCase() ?? '',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xl),

          // Sections
          _SectionHeader('Account'),
          _ProfileTile(
            icon: Icons.directions_car_outlined,
            label: 'My Vehicles',
            onTap: () {}, // Phase 2
          ),
          _ProfileTile(
            icon: Icons.location_on_outlined,
            label: 'Saved Addresses',
            onTap: () {}, // Phase 2
          ),
          _ProfileTile(
            icon: Icons.notifications_outlined,
            label: 'Notification Settings',
            onTap: () {}, // Phase 2
          ),

          const SizedBox(height: AppSpacing.md),
          _SectionHeader('Loyalty & Rewards'),
          _ProfileTile(
            icon: Icons.stars_outlined,
            label: 'Loyalty Status',
            onTap: () {}, // Phase 3
          ),
          _ProfileTile(
            icon: Icons.card_membership_outlined,
            label: 'Memberships',
            onTap: () {}, // Phase 3
          ),
          _ProfileTile(
            icon: Icons.people_outline,
            label: 'Refer a Friend',
            onTap: () {}, // Phase 3
          ),

          const SizedBox(height: AppSpacing.md),
          _SectionHeader('Preferences'),

          // Theme toggle
          ListTile(
            leading: const Icon(Icons.brightness_6_outlined),
            title: const Text('Theme'),
            trailing: DropdownButton<ThemeMode>(
              value: themeMode,
              underline: const SizedBox.shrink(),
              items: const [
                DropdownMenuItem(value: ThemeMode.system, child: Text('System')),
                DropdownMenuItem(value: ThemeMode.light, child: Text('Light')),
                DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
              ],
              onChanged: (m) {
                if (m != null) {
                  ref.read(themeModeProvider.notifier).setMode(m);
                }
              },
            ),
          ),

          const SizedBox(height: AppSpacing.xl),

          // Logout
          SecondaryButton(
            label: 'Sign Out',
            onPressed: () async {
              final session = ref.read(sessionStateProvider);
              final refresh = session.maybeWhen(
                authenticated: (_, __, r) => r,
                orElse: () => null,
              );
              if (refresh != null) {
                await ref.read(authRepositoryProvider).logout(refresh);
              } else {
                await ref.read(sessionControllerProvider.notifier).logout();
              }
            },
            icon: const Icon(Icons.logout_rounded, size: 18),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      trailing: const Icon(Icons.chevron_right, size: 18),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
    );
  }
}
