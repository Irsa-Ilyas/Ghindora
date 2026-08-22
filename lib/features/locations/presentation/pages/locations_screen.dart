import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/design_system/design_tokens.dart';
import '../../../../core/design_system/components/states/app_loader.dart';
import '../../providers/location_providers.dart';
import '../widgets/add_location_dialog.dart';

class LocationsScreen extends ConsumerWidget {
  const LocationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationsAsync = ref.watch(locationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Locations'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const AddLocationDialog(),
              );
            },
          ),
        ],
      ),
      body: locationsAsync.when(
        data: (locations) {
          if (locations.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.place_outlined,
                    size: 64,
                    color: Theme.of(context).hintColor,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'No locations yet.',
                    style: AppTextStyles.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const AddLocationDialog(),
                      );
                    },
                    child: const Text('Add Location'),
                  ),
                ],
              ),
            );
          }

          // Build hierarchy
          final rootLocations = locations.where((l) => l.parentId == null).toList();
          
          return ListView.builder(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: rootLocations.length,
            itemBuilder: (context, index) {
              final rootLoc = rootLocations[index];
              final children = locations.where((l) => l.parentId == rootLoc.id).toList();
              
              return Card(
                margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                elevation: 0,
                color: Theme.of(context).colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: AppSpacing.borderRadiusMd,
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
                  ),
                ),
                child: ExpansionTile(
                  title: Text(rootLoc.name, style: AppTextStyles.titleMedium),
                  subtitle: rootLoc.description != null ? Text(rootLoc.description!) : null,
                  leading: Icon(Icons.location_on, color: AppColors.primary),
                  childrenPadding: const EdgeInsets.only(left: AppSpacing.lg),
                  children: [
                    ...children.map((childLoc) => ListTile(
                      title: Text(childLoc.name),
                      subtitle: childLoc.description != null ? Text(childLoc.description!) : null,
                      leading: const Icon(Icons.subdirectory_arrow_right, size: 20),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline, size: 20),
                        onPressed: () async {
                           await ref.read(locationRepositoryProvider).deleteLocation(childLoc.id);
                        },
                      ),
                    )),
                    ListTile(
                      leading: const Icon(Icons.add, size: 20),
                      title: const Text('Add Sub-location'),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AddLocationDialog(initialParentId: rootLoc.id),
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.delete_outline, color: AppColors.error),
                      title: const Text('Delete Location', style: TextStyle(color: AppColors.error)),
                      onTap: () async {
                         await ref.read(locationRepositoryProvider).deleteLocation(rootLoc.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: AppLoader()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
