import 'package:flutter/material.dart';

import '../../../../core/design_system/design_tokens.dart';

class ItemImagePicker extends StatefulWidget {
  final String? initialImageUrl;
  final ValueChanged<String?>? onImageSelected;

  const ItemImagePicker({
    super.key,
    this.initialImageUrl,
    this.onImageSelected,
  });

  @override
  State<ItemImagePicker> createState() => _ItemImagePickerState();
}

class _ItemImagePickerState extends State<ItemImagePicker> {
  String? _selectedImage;

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.initialImageUrl;
  }

  void _handleTap() {
    // Structural mock behavior
    if (_selectedImage == null) {
      setState(() {
        _selectedImage = 'mock_image_path';
      });
      widget.onImageSelected?.call(_selectedImage);
    }
  }

  void _handleRemove() {
    setState(() {
      _selectedImage = null;
    });
    widget.onImageSelected?.call(null);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        child: _selectedImage == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_a_photo_outlined,
                    size: 48,
                    color: Theme.of(context).hintColor,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Add Photo',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ],
              )
            : Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: AppSpacing.borderRadiusMd,
                    child: Container(
                      color: AppColors.primaryContainer,
                      child: const Center(
                        child: Icon(
                          Icons.image,
                          size: 64,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: AppSpacing.sm,
                    right: AppSpacing.sm,
                    child: GestureDetector(
                      onTap: _handleRemove,
                      child: Container(
                        padding: const EdgeInsets.all(AppSpacing.xs),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
