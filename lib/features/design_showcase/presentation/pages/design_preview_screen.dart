import 'package:flutter/material.dart';

import '../../../../core/design_system/design_tokens.dart';
import '../../../../core/design_system/components/buttons/primary_button.dart';
import '../../../../core/design_system/components/buttons/secondary_button.dart';
import '../../../../core/design_system/components/buttons/text_button.dart';
import '../../../../core/design_system/components/buttons/icon_button.dart';
import '../../../../core/design_system/components/inputs/app_text_field.dart';
import '../../../../core/design_system/components/cards/app_card.dart';
import '../../../../core/design_system/components/cards/item_card.dart';
import '../../../../core/design_system/components/cards/location_card.dart';
import '../../../../core/design_system/components/states/app_empty_view.dart';
import '../../../../core/design_system/components/states/app_error_view.dart';
import '../../../../core/design_system/components/states/app_loader.dart';
import '../../../../core/design_system/components/navigation/app_bottom_navigation.dart';

class DesignPreviewScreen extends StatefulWidget {
  const DesignPreviewScreen({super.key});

  @override
  State<DesignPreviewScreen> createState() => _DesignPreviewScreenState();
}

class _DesignPreviewScreenState extends State<DesignPreviewScreen> {
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Design System Showcase')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Typography'),
            const Text('Display Large', style: AppTextStyles.displayLarge),
            const Text('Heading 1', style: AppTextStyles.h1),
            const Text('Heading 2', style: AppTextStyles.h2),
            const Text('Heading 3', style: AppTextStyles.h3),
            const Text('Title Large', style: AppTextStyles.titleLarge),
            const Text('Body Large', style: AppTextStyles.bodyLarge),
            const Text('Label Small', style: AppTextStyles.labelSmall),

            const SizedBox(height: AppSpacing.xl),
            _buildSectionHeader('Buttons'),
            PrimaryButton(text: 'Primary Button', onPressed: () {}),
            const SizedBox(height: AppSpacing.sm),
            SecondaryButton(
              text: 'Secondary Button',
              onPressed: () {},
              icon: Icons.open_in_new,
            ),
            const SizedBox(height: AppSpacing.sm),
            PrimaryButton(
              text: 'Loading Primary',
              onPressed: () {},
              isLoading: true,
            ),
            const SizedBox(height: AppSpacing.sm),
            PrimaryButton(
              text: 'Disabled Primary',
              onPressed: () {},
              isDisabled: true,
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: AppTextButton(text: 'Text Button', onPressed: () {}),
                ),
                const SizedBox(width: AppSpacing.sm),
                AppIconButton(icon: Icons.bookmark, onPressed: () {}),
              ],
            ),

            const SizedBox(height: AppSpacing.xl),
            _buildSectionHeader('Inputs'),
            const AppTextField(
              label: 'Email Address',
              hintText: 'Enter your email',
              prefixIcon: Icons.email_outlined,
            ),
            const SizedBox(height: AppSpacing.md),
            const AppTextField(
              label: 'Password',
              hintText: 'Enter your password',
              prefixIcon: Icons.lock_outline,
              isPassword: true,
            ),
            const SizedBox(height: AppSpacing.md),
            const AppTextField(
              label: 'Disabled Input',
              hintText: 'Cannot type here',
              isDisabled: true,
            ),
            const SizedBox(height: AppSpacing.md),
            const AppTextField(
              label: 'Error State',
              hintText: 'Something is wrong',
              errorText: 'Invalid format',
            ),

            const SizedBox(height: AppSpacing.xl),
            _buildSectionHeader('Cards'),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Base Elevated Card',
                    style: AppTextStyles.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'This is a simple elevated card using the default style.',
                    style: AppTextStyles.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            ItemCard(
              title: 'Premium Wireless Headphones',
              subtitle: 'Noise cancelling, 30hr battery',
              location: 'New York, USA',
              category: 'Electronics',
              status: 'Available',
              onTap: () {},
              onFavoriteTap: () {},
            ),
            const SizedBox(height: AppSpacing.md),
            LocationCard(
              title: 'Central Park Store',
              address: '123 Park Avenue, NY',
              distance: '1.2 km away',
              onTap: () {},
              onActionTap: () {},
            ),

            const SizedBox(height: AppSpacing.xl),
            _buildSectionHeader('States'),
            const AppCard(
              child: AppEmptyView(
                title: 'No Data Found',
                description:
                    'We could not find any matching results for your search.',
                icon: Icons.search_off,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            AppCard(
              child: AppErrorView(
                title: 'Connection Lost',
                message: 'Please check your internet connection and try again.',
                onRetry: () {},
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            const AppCard(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.xl),
                child: AppLoader(),
              ),
            ),

            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _navIndex,
        onTap: (i) => setState(() => _navIndex = i),
        items: const [
          AppBottomNavigationItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: 'Home',
          ),
          AppBottomNavigationItem(
            icon: Icons.search_outlined,
            activeIcon: Icons.search,
            label: 'Search',
          ),
          AppBottomNavigationItem(
            icon: Icons.person_outline,
            activeIcon: Icons.person,
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.h2.copyWith(color: AppColors.primary),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
