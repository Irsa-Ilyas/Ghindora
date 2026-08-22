import 'package:flutter/material.dart';

import '../../../../core/design_system/design_tokens.dart';
import '../../../../core/design_system/components/inputs/app_text_field.dart';
import 'item_image_picker.dart';

class ItemForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController descController;
  final TextEditingController categoryController;
  final ValueNotifier<String?> imagePathNotifier;
  final bool isEditMode;
  final String locationName;
  final VoidCallback? onSelectLocation;

  const ItemForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.descController,
    required this.categoryController,
    required this.imagePathNotifier,
    this.isEditMode = false,
    this.locationName = 'Select Location',
    this.onSelectLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Picker
          Text('Item Photo', style: AppTextStyles.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          ValueListenableBuilder<String?>(
            valueListenable: imagePathNotifier,
            builder: (context, imagePath, child) {
              return ItemImagePicker(
                initialImageUrl: imagePath,
                onImageSelected: (path) => imagePathNotifier.value = path,
              );
            },
          ),
          const SizedBox(height: AppSpacing.xl),

          // Basic Info
          Text('Basic Information', style: AppTextStyles.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(
            label: 'Item Name',
            hintText: 'e.g. Vintage Camera',
            controller: nameController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a name for the item';
              }
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            label: 'Category',
            hintText: 'e.g. Electronics, Furniture',
            controller: categoryController,
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            label: 'Description',
            hintText: 'Describe the item and its condition...',
            controller: descController,
            maxLines: 4,
          ),
          const SizedBox(height: AppSpacing.xl),

          // Location Section Placeholder
          Text('Location', style: AppTextStyles.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          InkWell(
            onTap: onSelectLocation,
            borderRadius: AppSpacing.borderRadiusMd,
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: AppSpacing.borderRadiusMd,
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline
                      .withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.location_on, color: AppColors.primary),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          locationName,
                          style: AppTextStyles.bodyLarge,
                        ),
                        if (locationName == 'Select Location')
                          Text(
                            'Tap to choose where this item is stored.',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: Theme.of(context).hintColor),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
