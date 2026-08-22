class ItemModel {
  final String id;
  final String name;
  final String description;
  final int? categoryId;
  final String category;
  final int? locationId;
  final String location;
  final bool isFavorite;
  final bool isImportant;
  final bool isArchived;
  final String? imagePath;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ItemModel({
    required this.id,
    required this.name,
    required this.description,
    this.categoryId,
    required this.category,
    this.locationId,
    required this.location,
    this.isFavorite = false,
    this.isImportant = false,
    this.isArchived = false,
    this.imagePath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ItemModel.fromEntity(dynamic entity, {String categoryName = 'Unknown', String locationName = 'Unknown'}) {
    // We use dynamic to avoid circular dependencies with Drift database layer if not strictly needed, 
    // but ideally we'd depend on ItemEntity.
    return ItemModel(
      id: entity.id.toString(),
      name: entity.title,
      description: entity.description ?? '',
      categoryId: entity.categoryId,
      category: categoryName,
      locationId: entity.locationId,
      location: locationName,
      isFavorite: entity.isFavorite,
      isImportant: entity.isImportant,
      isArchived: entity.isArchived,
      imagePath: entity.imagePath,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}

// Temporary Mock Data for UI/Navigation testing only.
// This will be replaced by Riverpod / real Repositories in the future.
final List<ItemModel> mockItems = [
  ItemModel(
    id: '1',
    name: 'Vintage Camera',
    description: 'A beautiful vintage camera in perfect working condition. Comes with original leather case and two lenses.',
    category: 'Electronics',
    location: 'Living Room Shelf',
    isFavorite: true,
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    updatedAt: DateTime.now().subtract(const Duration(days: 2)),
  ),
  ItemModel(
    id: '2',
    name: 'Wooden Coffee Table',
    description: 'Handcrafted oak coffee table with minimal design. Great for small spaces.',
    category: 'Furniture',
    location: 'Storage Unit B',
    isFavorite: false,
    createdAt: DateTime.now().subtract(const Duration(days: 15)),
    updatedAt: DateTime.now().subtract(const Duration(days: 2)),
  ),
  ItemModel(
    id: '3',
    name: 'Mountain Bike',
    description:
        '21-speed mountain bike. Just serviced last month. Needs a new seat.',
    category: 'Sports',
    location: 'Garage',
    isFavorite: true,
    createdAt: DateTime.now().subtract(const Duration(days: 30)),
    updatedAt: DateTime.now().subtract(const Duration(days: 5)),
  ),
];
