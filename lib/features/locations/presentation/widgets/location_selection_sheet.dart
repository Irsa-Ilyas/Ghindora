import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/design_system/design_tokens.dart';
import '../../../../core/design_system/components/states/app_loader.dart';
import '../../providers/location_providers.dart';
import '../../domain/location_model.dart';
import 'add_location_dialog.dart';

class LocationSelectionSheet extends ConsumerWidget {
  final int? selectedLocationId;

  const LocationSelectionSheet({
    super.key,
    this.selectedLocationId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationsAsync = ref.watch(locationsProvider);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Select Location', style: AppTextStyles.titleLarge),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ElevatedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const AddLocationDialog(),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('Add New Location'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              foregroundColor: AppColors.primary,
              elevation: 0,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: locationsAsync.when(
              data: (locations) {
                if (locations.isEmpty) {
                  return Center(
                    child: Text(
                      'No locations yet.',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  );
                }

                // Simple flat list for now, we can indent later for hierarchy
                return ListView.separated(
                  itemCount: locations.length,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final location = locations[index];
                    final isSelected = location.id == selectedLocationId;
                    
                    // Simple hack to show hierarchy visually
                    final isChild = location.parentId != null;

                    return ListTile(
                      contentPadding: EdgeInsets.only(left: isChild ? 32.0 : 0.0, right: 8.0),
                      leading: Icon(
                        isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                        color: isSelected ? AppColors.primary : Theme.of(context).hintColor,
                      ),
                      title: Text(location.name),
                      subtitle: location.description != null ? Text(location.description!) : null,
                      onTap: () => Navigator.pop(context, location),
                    );
                  },
                );
              },
              loading: () => const AppLoader(),
              error: (e, st) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
    );
  }
}
