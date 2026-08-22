import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/design_system/design_tokens.dart';
import '../../../../core/design_system/components/inputs/app_text_field.dart';
import '../../../../core/design_system/components/buttons/primary_button.dart';
import '../../providers/location_providers.dart';

class AddLocationDialog extends ConsumerStatefulWidget {
  final int? initialParentId;

  const AddLocationDialog({super.key, this.initialParentId});

  @override
  ConsumerState<AddLocationDialog> createState() => _AddLocationDialogState();
}

class _AddLocationDialogState extends ConsumerState<AddLocationDialog> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  int? _selectedParentId;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedParentId = widget.initialParentId;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _saveLocation() async {
    if (_nameController.text.trim().isEmpty) return;

    setState(() => _isLoading = true);

    try {
      final repo = ref.read(locationRepositoryProvider);
      await repo.addLocation(
        _nameController.text.trim(),
        description: _descController.text.trim().isNotEmpty ? _descController.text.trim() : null,
        parentId: _selectedParentId,
      );
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add location: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationsAsync = ref.watch(locationsProvider);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Add Location', style: AppTextStyles.titleLarge),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              controller: _nameController,
              label: 'Location Name',
              hintText: 'e.g. Garage, Bedroom, Box 1',
              prefixIcon: Icons.place_outlined,
            ),
            const SizedBox(height: AppSpacing.sm),
            AppTextField(
              controller: _descController,
              label: 'Description (Optional)',
              hintText: 'e.g. Top shelf',
              prefixIcon: Icons.description_outlined,
            ),
            const SizedBox(height: AppSpacing.sm),
            
            // Parent Location Dropdown
            Text('Parent Location (Optional)', style: AppTextStyles.labelMedium),
            const SizedBox(height: 4),
            locationsAsync.when(
              data: (locations) {
                return DropdownButtonFormField<int?>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: AppSpacing.borderRadiusSm,
                      borderSide: BorderSide(color: Theme.of(context).dividerColor),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  ),
                  value: _selectedParentId,
                  hint: const Text('Select a parent location'),
                  items: [
                    const DropdownMenuItem<int?>(
                      value: null,
                      child: Text('None (Root Location)'),
                    ),
                    ...locations.map((loc) {
                      return DropdownMenuItem<int?>(
                        value: loc.id,
                        child: Text(loc.name),
                      );
                    }),
                  ],
                  onChanged: (val) {
                    setState(() {
                      _selectedParentId = val;
                    });
                  },
                );
              },
              loading: () => const LinearProgressIndicator(),
              error: (_, __) => const SizedBox(),
            ),
            
            const SizedBox(height: AppSpacing.lg),
            PrimaryButton(
              text: 'Save Location',
              isLoading: _isLoading,
              onPressed: _saveLocation,
            ),
          ],
        ),
      ),
    );
  }
}
