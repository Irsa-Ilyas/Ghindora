import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../core/design_system/design_tokens.dart';
import '../../../../core/design_system/components/states/app_empty_view.dart';
import '../../../../core/design_system/components/states/app_loader.dart';
import '../../../../core/design_system/components/cards/item_card.dart';
import '../../providers/item_providers.dart';

class ArchivedItemsPage extends ConsumerWidget {
  const ArchivedItemsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final archivedItemsAsync = ref.watch(archivedItemsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Archived Items')),
      body: archivedItemsAsync.when(
        data: (archivedItems) {
          if (archivedItems.isEmpty) {
            return const AppEmptyView(
              title: 'No Archived Items',
              description: 'Items you archive will appear here.',
              icon: Icons.archive_outlined,
              useSecondaryButton: false,
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: archivedItems.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              final item = archivedItems[index];
              return ItemCard(
                title: item.name,
                subtitle: item.description,
                category: item.category,
                location: item.location,
                imagePath: item.imagePath,
                isFavorite: item.isFavorite,
                isImportant: item.isImportant,
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
