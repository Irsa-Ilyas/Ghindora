import 'package:flutter/material.dart';

import '../../design_tokens.dart';
import 'app_card.dart';

class LocationCard extends StatelessWidget {
  final String title;
  final String address;
  final String? distance;
  final VoidCallback? onTap;
  final VoidCallback? onActionTap;
  final IconData? actionIcon;

  const LocationCard({
    super.key,
    required this.title,
    required this.address,
    this.distance,
    this.onTap,
    this.onActionTap,
    this.actionIcon,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      style: AppCardStyle.outlined,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.primaryContainer.withValues(alpha: 0.5),
              borderRadius: AppSpacing.borderRadiusMd,
            ),
            child: const Icon(
              Icons.location_on,
              color: AppColors.primary,
              size: AppSpacing.iconMd,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  address,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (distance != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    distance!,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (onActionTap != null) ...[
            const SizedBox(width: AppSpacing.sm),
            IconButton(
              icon: Icon(actionIcon ?? Icons.directions),
              onPressed: onActionTap,
              color: AppColors.primary,
            ),
          ],
        ],
      ),
    );
  }
}
