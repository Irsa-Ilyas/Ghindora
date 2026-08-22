import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ghindora/app/router/route_names.dart';
import 'package:ghindora/core/design_system/design_tokens.dart';
import 'package:ghindora/core/design_system/components/cards/item_card.dart';
import 'package:ghindora/core/design_system/components/states/app_empty_view.dart';
import 'package:ghindora/core/design_system/components/states/app_loader.dart';
import 'package:ghindora/features/items/providers/item_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeItemsAsync = ref.watch(activeItemsProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(RouteNames.addItem),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome Back,',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      const Text('John Doe', style: AppTextStyles.h2),
                    ],
                  ),
                  CircleAvatar(
                    radius: AppSpacing.avatarSm / 2,
                    backgroundColor: AppColors.primaryContainer,
                    child: const Icon(Icons.person, color: AppColors.primary),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),

              // Search Entry Point (Structural)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: AppSpacing.borderRadiusMd,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline
                        .withValues(alpha: 0.5),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Theme.of(context).hintColor),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      'Search for items...',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Quick Actions Placeholder
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildQuickAction(
                    context,
                    Icons.local_offer_outlined,
                    'Offers',
                  ),
                  _buildQuickAction(
                    context,
                    Icons.category_outlined,
                    'Categories',
                  ),
                  _buildQuickAction(
                    context,
                    Icons.new_releases_outlined,
                    'New',
                  ),
                  _buildQuickAction(context, Icons.trending_up, 'Popular'),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),

              // Recent Items / All Items
              Text('Your Belongings', style: AppTextStyles.h3),
              const SizedBox(height: AppSpacing.md),

              activeItemsAsync.when(
                data: (items) {
                  if (items.isEmpty) {
                    return AppEmptyView(
                      title: 'No items yet',
                      description: 'Start remembering the things\nthat matter to you.',
                      icon: Icons.inventory_2_outlined,
                      actionText: 'Add Your First Item',
                      onActionTap: () => context.push(RouteNames.addItem),
                      useSecondaryButton: false,
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.md),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return ItemCard(
                        title: item.name,
                        subtitle: item.description,
                        location: item.location,
                        status: item.category,
                        imagePath: item.imagePath,
                        isFavorite: item.isFavorite,
                        isImportant: item.isImportant,
                        onTap: () {
                          context.push(
                            RouteNames.itemDetail.replaceAll(':itemId', item.id),
                          );
                        },
                        onFavoriteTap: () {
                          ref.read(itemRepositoryProvider).toggleFavorite(int.parse(item.id), item.isFavorite);
                        },
                        onImportantTap: () {
                          ref.read(itemRepositoryProvider).toggleImportant(int.parse(item.id), item.isImportant);
                        },
                      );
                    },
                  );
                },
                loading: () => const Padding(
                  padding: EdgeInsets.all(AppSpacing.xl),
                  child: AppLoader(),
                ),
                error: (error, stack) => Center(
                  child: Text('Couldn\'t load your items:\n$error'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAction(BuildContext context, IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, color: AppColors.primary),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(label, style: AppTextStyles.labelSmall),
      ],
    );
  }
}
