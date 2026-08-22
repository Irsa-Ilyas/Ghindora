import 'package:flutter/material.dart';

import '../../../../core/design_system/design_tokens.dart';
import '../../../../core/design_system/components/inputs/app_text_field.dart';
import '../../../../core/design_system/components/states/app_empty_view.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: AppTextField(
              label: '',
              hintText: 'Search items, categories...',
              prefixIcon: Icons.search,
            ),
          ),
        ),
      ),
      body: const AppEmptyView(
        title: 'Start Searching',
        description: 'Find exactly what you are looking for by typing above.',
        icon: Icons.search,
        useSecondaryButton: true,
      ),
    );
  }
}
