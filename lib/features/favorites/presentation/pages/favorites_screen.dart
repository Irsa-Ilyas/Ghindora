import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ghindora/app/router/route_names.dart';
import 'package:ghindora/core/design_system/design_tokens.dart';
import 'package:ghindora/core/design_system/components/states/app_empty_view.dart';
import 'package:ghindora/core/design_system/components/states/app_loader.dart';
import 'package:ghindora/core/design_system/components/cards/item_card.dart';
import 'package:ghindora/features/items/providers/item_providers.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteItemsAsync = ref.watch(favoriteItemsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: favoriteItemsAsync.when(
        data: (favoriteItems) {
          if (favoriteItems.isEmpty) {
            return const AppEmptyView(
              title: 'No Favorites Yet',
              description: 'Items you favorite will appear here so you can easily find them later.',
              icon: Icons.favorite_border,
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: favoriteItems.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              final item = favoriteItems[index];
              return ItemCard(
                title: item.name,
                subtitle: item.description,
                category: item.category,
                location: item.location,
                imagePath: item.imagePath,
                isFavorite: item.isFavorite,
                isImportant: item.isImportant,
                onFavoriteTap: () {
                  ref.read(itemRepositoryProvider).toggleFavorite(int.parse(item.id), item.isFavorite);
                },
                onImportantTap: () {
                  ref.read(itemRepositoryProvider).toggleImportant(int.parse(item.id), item.isImportant);
                },
                onTap: () {
                  context.push(
                    RouteNames.itemDetail.replaceAll(':itemId', item.id),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: AppLoader()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
