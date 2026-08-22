import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/providers/database_provider.dart';
import '../data/item_repository.dart';
import '../domain/item_model.dart';

final itemRepositoryProvider = Provider<ItemRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return ItemRepository(db);
});

final activeItemsProvider = StreamProvider<List<ItemModel>>((ref) {
  final repo = ref.watch(itemRepositoryProvider);
  return repo.watchActiveItems();
});

final favoriteItemsProvider = StreamProvider<List<ItemModel>>((ref) {
  final repo = ref.watch(itemRepositoryProvider);
  return repo.watchFavoriteItems();
});

final importantItemsProvider = StreamProvider<List<ItemModel>>((ref) {
  final repo = ref.watch(itemRepositoryProvider);
  return repo.watchImportantItems();
});

final recentlyAddedItemsProvider = StreamProvider<List<ItemModel>>((ref) {
  final repo = ref.watch(itemRepositoryProvider);
  return repo.watchRecentlyAdded();
});

final archivedItemsProvider = StreamProvider<List<ItemModel>>((ref) {
  final repo = ref.watch(itemRepositoryProvider);
  return repo.watchArchivedItems();
});

final itemByIdProvider = StreamProvider.family<ItemModel?, int>((ref, id) {
  final repo = ref.watch(itemRepositoryProvider);
  return repo.watchItem(id);
});



final recentlyUpdatedItemsProvider = StreamProvider<List<ItemModel>>((ref) {
  final repo = ref.watch(itemRepositoryProvider);
  return repo.watchRecentlyUpdated();
});
