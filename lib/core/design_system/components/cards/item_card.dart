import 'dart:io';
import 'package:flutter/material.dart';

import '../../design_tokens.dart';
import 'app_card.dart';
import '../buttons/icon_button.dart';

class ItemCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? location;
  final String? category;
  final String? status;
  final String? imagePath;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onImportantTap;
  final bool isFavorite;
  final bool isImportant;

  const ItemCard({
    super.key,
    required this.title,
    this.subtitle,
    this.location,
    this.category,
    this.status,
    this.imagePath,
    this.onTap,
    this.onFavoriteTap,
    this.onImportantTap,
    this.isFavorite = false,
    this.isImportant = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail Area
          Stack(
            children: [
              Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).disabledColor.withValues(alpha: 0.1),
                  image: imagePath != null && File(imagePath!).existsSync()
                      ? DecorationImage(
                          image: FileImage(File(imagePath!)),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: (imagePath == null || !File(imagePath!).existsSync())
                    ? Icon(
                        Icons.image_outlined,
                        size: 48,
                        color: Theme.of(context).disabledColor,
                      )
                    : null,
              ),
              if (category != null)
                Positioned(
                  top: AppSpacing.sm,
                  left: AppSpacing.sm,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: AppSpacing.borderRadiusSm,
                    ),
                    child: Text(
                      category!,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.onPrimary,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: AppSpacing.sm,
                  right: AppSpacing.sm,
                  child: Row(
                    children: [
                      if (onImportantTap != null)
                        Container(
                          margin: const EdgeInsets.only(right: AppSpacing.xs),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor.withValues(alpha: 0.8),
                            shape: BoxShape.circle,
                          ),
                          child: AppIconButton(
                            icon: isImportant ? Icons.star : Icons.star_border,
                            color: isImportant
                                ? AppColors.warning
                                : Theme.of(context).iconTheme.color,
                            onPressed: onImportantTap,
                            size: 20,
                          ),
                        ),
                      if (onFavoriteTap != null)
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor.withValues(alpha: 0.8),
                            shape: BoxShape.circle,
                          ),
                          child: AppIconButton(
                            icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite
                                ? AppColors.error
                                : Theme.of(context).iconTheme.color,
                            onPressed: onFavoriteTap,
                            size: 20,
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),

          // Content Area
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: AppTextStyles.titleMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (status != null) ...[
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        status!,
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ],
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    subtitle!,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                if (location != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: Theme.of(context).hintColor,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location!,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: Theme.of(context).hintColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
