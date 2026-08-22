import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/theme_provider.dart';
import '../../../../core/design_system/design_tokens.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // Profile Placeholder
          Row(
            children: [
              CircleAvatar(
                radius: AppSpacing.avatarMd / 2,
                backgroundColor: AppColors.primaryContainer,
                child: const Icon(
                  Icons.person,
                  color: AppColors.primary,
                  size: 32,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('John Doe', style: AppTextStyles.titleMedium),
                  Text(
                    'john.doe@example.com',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),

          // Appearance
          _buildSectionHeader(context, 'Appearance'),
          const SizedBox(height: AppSpacing.sm),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: AppSpacing.borderRadiusMd,
            ),
            child: Column(
              children: [
                ListTile(
                  title: const Text('System Default'),
                  trailing: themeMode == ThemeMode.system
                      ? const Icon(Icons.check, color: AppColors.primary)
                      : null,
                  onTap: () => ref
                      .read(themeModeProvider.notifier)
                      .setTheme(ThemeMode.system),
                ),
                ListTile(
                  title: const Text('Light Mode'),
                  trailing: themeMode == ThemeMode.light
                      ? const Icon(Icons.check, color: AppColors.primary)
                      : null,
                  onTap: () => ref
                      .read(themeModeProvider.notifier)
                      .setTheme(ThemeMode.light),
                ),
                ListTile(
                  title: const Text('Dark Mode'),
                  trailing: themeMode == ThemeMode.dark
                      ? const Icon(Icons.check, color: AppColors.primary)
                      : null,
                  onTap: () => ref
                      .read(themeModeProvider.notifier)
                      .setTheme(ThemeMode.dark),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // General Settings Placeholder
          _buildSectionHeader(context, 'General'),
          const SizedBox(height: AppSpacing.sm),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: AppSpacing.borderRadiusMd,
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.notifications_outlined),
                  title: const Text('Notifications'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.language_outlined),
                  title: const Text('Language'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.archive_outlined),
                  title: const Text('Archived Items'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    context.push(RouteNames.archivedItems);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // About Settings Placeholder
          _buildSectionHeader(context, 'About'),
          const SizedBox(height: AppSpacing.sm),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: AppSpacing.borderRadiusMd,
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('About Ghindora'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.privacy_tip_outlined),
                  title: const Text('Privacy Policy'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title.toUpperCase(),
      style: AppTextStyles.labelSmall.copyWith(
        color: Theme.of(context).hintColor,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
      ),
    );
  }
}
