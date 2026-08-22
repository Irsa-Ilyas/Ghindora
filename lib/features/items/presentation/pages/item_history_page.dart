import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/design_system/design_tokens.dart';
import '../../../../core/design_system/components/states/app_loader.dart';
import '../../../../core/design_system/components/states/app_empty_view.dart';
import '../../providers/item_history_providers.dart';

class ItemHistoryPage extends ConsumerWidget {
  final String itemId;

  const ItemHistoryPage({super.key, required this.itemId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final intId = int.tryParse(itemId) ?? -1;
    final historyAsync = ref.watch(itemHistoryProvider(intId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Trail'),
      ),
      body: historyAsync.when(
        data: (history) {
          if (history.isEmpty) {
            return AppEmptyView(
              title: 'No Memory Trail',
              description: 'This item hasn\'t been moved yet.',
              icon: Icons.history,
              actionText: 'Go Back',
              onActionTap: () => Navigator.pop(context),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: history.length,
            itemBuilder: (context, index) {
              final entry = history[index];
              final isFirst = index == 0;
              final isLast = index == history.length - 1;

              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Timeline indicator
                    SizedBox(
                      width: 40,
                      child: Column(
                        children: [
                          Container(
                            width: 2,
                            height: 20,
                            color: isFirst ? Colors.transparent : Theme.of(context).dividerColor,
                          ),
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isFirst ? AppColors.primary : Theme.of(context).dividerColor,
                              border: Border.all(
                                color: Theme.of(context).scaffoldBackgroundColor,
                                width: 2,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: 2,
                              color: isLast ? Colors.transparent : Theme.of(context).dividerColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Content
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat.yMMMd().add_jm().format(entry.createdAt),
                              style: AppTextStyles.labelSmall.copyWith(
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            if (entry.action == 'moved') ...[
                              Text(
                                'Moved to ${entry.newLocationName ?? 'Unknown'}',
                                style: AppTextStyles.bodyLarge.copyWith(
                                  fontWeight: isFirst ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                              if (entry.oldLocationName != null)
                                Text(
                                  'From: ${entry.oldLocationName}',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                            ] else if (entry.action == 'created') ...[
                              Text(
                                'Added to ${entry.newLocationName ?? 'Unknown'}',
                                style: AppTextStyles.bodyLarge,
                              ),
                            ] else ...[
                              Text(
                                'Action: ${entry.action}',
                                style: AppTextStyles.bodyLarge,
                              ),
                            ]
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: AppLoader()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
