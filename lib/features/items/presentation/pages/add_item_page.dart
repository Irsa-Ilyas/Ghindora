import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' as drift;

import '../../../../core/design_system/design_tokens.dart';
import '../../../../core/design_system/components/buttons/primary_button.dart';
import '../../../../core/database/database.dart';
import '../widgets/item_form.dart';
import '../../../../core/database/providers/database_provider.dart';
import '../../../locations/domain/location_model.dart';
import '../../../locations/presentation/widgets/location_selection_sheet.dart';

class AddItemPage extends ConsumerStatefulWidget {
  const AddItemPage({super.key});

  @override
  ConsumerState<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends ConsumerState<AddItemPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descController;
  late final TextEditingController _categoryController;
  final ValueNotifier<String?> _imagePathNotifier = ValueNotifier(null);
  
  int? _selectedLocationId;
  String _selectedLocationName = 'Select Location';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descController = TextEditingController();
    _categoryController = TextEditingController();
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
      
      // For now, since we don't have location/category creation flow fully wired up to DB,
      // we'll insert a mock category if we need to. But let's just insert the item directly 
      // with null categoryId for simplicity or assume we parse category later.
      
      final itemId = await db.itemsDao.insertItem(ItemsCompanion.insert(
        title: _nameController.text.trim(),
        description: drift.Value(_descController.text.trim()),
        locationId: drift.Value(_selectedLocationId),
        imagePath: drift.Value(_imagePathNotifier.value),
        createdAt: drift.Value(DateTime.now()),
        updatedAt: drift.Value(DateTime.now()),
      ));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Item successfully added!'))
        );
        context.pushReplacement('/items/$itemId');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding item: $e'))
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
    return Scaffold(
      appBar: AppBar(title: const Text('Add Item')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: ItemForm(
                  formKey: _formKey, 
                  isEditMode: false,
                  nameController: _nameController,
                  descController: _descController,
                  categoryController: _categoryController,
                  imagePathNotifier: _imagePathNotifier,
                  locationName: _selectedLocationName,
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
                text: 'Save Item',
                isLoading: _isLoading,
                onPressed: _handleSave,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
