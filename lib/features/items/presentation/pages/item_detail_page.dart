import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/router/route_names.dart';
import '../../../../core/design_system/design_tokens.dart';
import '../../../../core/design_system/components/buttons/primary_button.dart';
import '../../../../core/design_system/components/buttons/secondary_button.dart';
import '../../../../core/design_system/components/states/app_loader.dart';
import '../../../../core/design_system/components/states/app_empty_view.dart';
import '../../providers/item_providers.dart';
import '../../../locations/domain/location_model.dart';
import '../../../locations/presentation/widgets/location_selection_sheet.dart';

class ItemDetailPage extends ConsumerWidget {
  final String itemId;

  const ItemDetailPage({super.key, required this.itemId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final intId = int.tryParse(itemId) ?? -1;
    final itemAsync = ref.watch(itemByIdProvider(intId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
        actions: itemAsync.value != null ? [
          IconButton(
            icon: Icon(
              itemAsync.value!.isImportant ? Icons.star : Icons.star_border,
              color: itemAsync.value!.isImportant ? AppColors.warning : null,
            ),
            onPressed: () {
              ref.read(itemRepositoryProvider).toggleImportant(intId, itemAsync.value!.isImportant);
            },
          ),
          IconButton(
            icon: Icon(
              itemAsync.value!.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: itemAsync.value!.isFavorite ? AppColors.error : null,
            ),
            onPressed: () {
              ref.read(itemRepositoryProvider).toggleFavorite(intId, itemAsync.value!.isFavorite);
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'archive') {
                await ref.read(itemRepositoryProvider).archiveItem(intId);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Item archived')),
                  );
                  context.pop();
                }
              } else if (value == 'restore') {
                await ref.read(itemRepositoryProvider).restoreItem(intId);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Item restored')),
                  );
                }
              } else if (value == 'delete') {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Item?'),
                    content: const Text('This item and its saved information will be permanently removed.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        style: TextButton.styleFrom(foregroundColor: AppColors.error),
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  await ref.read(itemRepositoryProvider).deleteItem(intId);
                  if (context.mounted) {
                    context.pop();
                  }
                }
              }
            },
            itemBuilder: (BuildContext context) {
              final isArchived = itemAsync.value!.isArchived;
              return [
                if (!isArchived)
                  const PopupMenuItem(
                    value: 'archive',
                    child: Text('Archive'),
                  ),
                if (isArchived)
                  const PopupMenuItem(
                    value: 'restore',
                    child: Text('Restore'),
                  ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete', style: TextStyle(color: AppColors.error)),
                ),
              ];
            },
          ),
        ] : null,
      ),
      body: itemAsync.when(
        data: (item) {
          if (item == null) {
            return AppEmptyView(
              title: 'Item Not Found',
              description: 'This item may have been deleted.',
              icon: Icons.error_outline,
              actionText: 'Back to Items',
              onActionTap: () => context.pop(),
            );
          }

          final dateFormat = DateFormat.yMMMd().add_jm();

          return SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                Container(
                  height: 250,
                  width: double.infinity,
                  color: Theme.of(context).disabledColor.withValues(alpha: 0.1),
                  child: item.imagePath != null && File(item.imagePath!).existsSync()
                      ? Image.file(
                          File(item.imagePath!),
                          fit: BoxFit.cover,
                        )
                      : Icon(
                          Icons.image_outlined,
                          size: 80,
                          color: Theme.of(context).disabledColor,
                        ),
                ),

                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              item.category,
                              style: AppTextStyles.labelSmall.copyWith(
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                          ),
                          Text(
                            'Updated ${dateFormat.format(item.updatedAt)}',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(item.name, style: AppTextStyles.displaySmall),
                      const SizedBox(height: AppSpacing.md),

                      // Location Info
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: AppColors.primary,
                            size: 20,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Expanded(child: Text(item.location, style: AppTextStyles.titleMedium)),
                          TextButton.icon(
                            onPressed: () {
                              context.push(RouteNames.itemHistory.replaceAll(':itemId', item.id));
                            },
                            icon: const Icon(Icons.history, size: 16),
                            label: const Text('Memory Trail'),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // Description
                      if (item.description.isNotEmpty) ...[
                        Text(
                          'Description',
                          style: AppTextStyles.titleMedium.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(item.description, style: AppTextStyles.bodyLarge),
                        const SizedBox(height: AppSpacing.xxl),
                      ],

                      // Actions
                      Row(
                        children: [
                          Expanded(
                            child: SecondaryButton(
                              text: 'Move Item',
                              onPressed: () async {
                                final selectedLoc = await showModalBottomSheet<LocationModel>(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => LocationSelectionSheet(
                                    selectedLocationId: item.locationId,
                                  ),
                                );
                                if (selectedLoc != null && context.mounted) {
                                  if (selectedLoc.id == item.locationId) return; // No change
                                  await ref.read(itemRepositoryProvider).moveItem(
                                    intId, 
                                    selectedLoc.id,
                                    oldLocationId: item.locationId,
                                  );
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Moved to ${selectedLoc.name}')),
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: PrimaryButton(
                              text: 'Edit Item',
                              onPressed: () {
                                context.push(
                                  RouteNames.editItem.replaceAll(
                                    ':itemId',
                                    item.id,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: AppLoader()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
