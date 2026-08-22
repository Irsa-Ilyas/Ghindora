import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' as drift;

import '../../../../core/design_system/design_tokens.dart';
import '../../../../core/design_system/components/buttons/primary_button.dart';
import '../../../../core/design_system/components/states/app_loader.dart';
import '../../../../core/design_system/components/states/app_empty_view.dart';
import '../../../../core/database/database.dart';
import '../widgets/item_form.dart';
import '../../providers/item_providers.dart';
import '../../../../core/database/providers/database_provider.dart';
import '../../../locations/domain/location_model.dart';
import '../../../locations/presentation/widgets/location_selection_sheet.dart';

class EditItemPage extends ConsumerStatefulWidget {
  final String itemId;

  const EditItemPage({super.key, required this.itemId});

  @override
  ConsumerState<EditItemPage> createState() => _EditItemPageState();
}

class _EditItemPageState extends ConsumerState<EditItemPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descController;
  late final TextEditingController _categoryController;
  late final ValueNotifier<String?> _imagePathNotifier;
  
  int? _selectedLocationId;
  String? _selectedLocationName;
  bool _isLoading = false;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descController = TextEditingController();
    _categoryController = TextEditingController();
    _imagePathNotifier = ValueNotifier(null);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _categoryController.dispose();
    _imagePathNotifier.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    
    try {
      final db = ref.read(databaseProvider);
      final intId = int.tryParse(widget.itemId) ?? -1;
      
      final oldItem = await db.itemsDao.getItem(intId);
      final newImagePath = _imagePathNotifier.value;
      
      await db.itemsDao.updateItem(ItemsCompanion(
        id: drift.Value(intId),
        title: drift.Value(_nameController.text.trim()),
        description: drift.Value(_descController.text.trim()),
        locationId: drift.Value(_selectedLocationId),
        imagePath: drift.Value(newImagePath),
        updatedAt: drift.Value(DateTime.now()),
      ));
      
      // Handle image deletion logic
      if (oldItem.imagePath != null && oldItem.imagePath != newImagePath) {
         try {
           final file = File(oldItem.imagePath!);
           if (await file.exists()) {
             await file.delete();
           }
         } catch (e) {
           // ignore
         }
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Changes saved successfully!')),
        );
        context.pop();
      }
    } catch (e) {
       if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating item: $e'))
        );
      }
    } finally {
       if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final intId = int.tryParse(widget.itemId) ?? -1;
    final itemAsync = ref.watch(itemByIdProvider(intId));
    
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Item')),
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
          
          if (!_isInitialized) {
            _nameController.text = item.name;
            _descController.text = item.description;
            _categoryController.text = item.category;
            _imagePathNotifier.value = item.imagePath;
            _selectedLocationId = item.locationId;
            _selectedLocationName = item.location;
            _isInitialized = true; // only init once to avoid overriding user input
          }

          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: ItemForm(
                      formKey: _formKey,
                      isEditMode: true,
                      nameController: _nameController,
                      descController: _descController,
                      categoryController: _categoryController,
                      imagePathNotifier: _imagePathNotifier,
                      locationName: _selectedLocationName ?? item.location,
                      onSelectLocation: () async {
                        final selectedLoc = await showModalBottomSheet<LocationModel>(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => LocationSelectionSheet(
                            selectedLocationId: _selectedLocationId,
                          ),
                        );
                        if (selectedLoc != null && mounted) {
                          setState(() {
                            _selectedLocationId = selectedLoc.id;
                            _selectedLocationName = selectedLoc.name;
                          });
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: PrimaryButton(
                    text: 'Save Changes',
                    isLoading: _isLoading,
                    onPressed: _handleSave,
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
