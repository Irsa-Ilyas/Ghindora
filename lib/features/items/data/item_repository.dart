import 'dart:io';
import 'package:drift/drift.dart';
import 'package:rxdart/rxdart.dart';
import '../../../core/database/database.dart';
import '../domain/item_model.dart';

class ItemRepository {
  final AppDatabase _db;

  ItemRepository(this._db);

  Stream<List<ItemModel>> _mapItemsWithLocations(Stream<List<ItemEntity>> itemsStream) {
    return Rx.combineLatest2(
      itemsStream,
      _db.locationsDao.watchAllLocations(),
      (List<ItemEntity> items, List<LocationEntity> locations) {
        return items.map((e) {
          final loc = locations.where((l) => l.id == e.locationId).firstOrNull;
          return ItemModel.fromEntity(e, locationName: loc?.name ?? 'Unknown');
        }).toList();
      }
    );
  }

  Stream<List<ItemModel>> watchActiveItems() {
    return _mapItemsWithLocations(_db.itemsDao.watchActiveItems());
  }

  Stream<ItemModel?> watchItem(int id) {
    return _mapItemsWithLocations(_db.itemsDao.watchAllItems()).map((items) {
      return items.where((e) => e.id == id.toString()).firstOrNull;
    });
  }

  Stream<List<ItemModel>> watchFavoriteItems() {
    return _mapItemsWithLocations(_db.itemsDao.watchFavoriteItems());
  }

  Stream<List<ItemModel>> watchImportantItems() {
    return _mapItemsWithLocations(_db.itemsDao.watchImportantItems());
  }

  Stream<List<ItemModel>> watchRecentlyAdded() {
    return _mapItemsWithLocations(_db.itemsDao.watchRecentlyAdded());
  }

  Stream<List<ItemModel>> watchRecentlyUpdated() {
    return _mapItemsWithLocations(_db.itemsDao.watchRecentlyUpdated());
  }

  Stream<List<ItemModel>> watchArchivedItems() {
    return _mapItemsWithLocations(_db.itemsDao.watchArchivedItems());
  }

  Future<void> toggleFavorite(int id, bool currentStatus) async {
    await _db.itemsDao.updateItem(
      ItemsCompanion(
        id: Value(id),
        isFavorite: Value(!currentStatus),
        updatedAt: Value(DateTime.now()),
      )
    );
  }

  Future<void> toggleImportant(int id, bool currentStatus) async {
    await _db.itemsDao.updateItem(
      ItemsCompanion(
        id: Value(id),
        isImportant: Value(!currentStatus),
        updatedAt: Value(DateTime.now()),
      )
    );
  }

  Future<void> archiveItem(int id) async {
    await _db.itemsDao.updateItem(
      ItemsCompanion(
        id: Value(id),
        isArchived: const Value(true),
        updatedAt: Value(DateTime.now()),
      )
    );
    await _db.itemHistoryDao.insertHistory(ItemHistoryCompanion.insert(
      itemId: id,
      action: 'archived',
    ));
  }

  Future<void> restoreItem(int id) async {
    await _db.itemsDao.updateItem(
      ItemsCompanion(
        id: Value(id),
        isArchived: const Value(false),
        updatedAt: Value(DateTime.now()),
      )
    );
    await _db.itemHistoryDao.insertHistory(ItemHistoryCompanion.insert(
      itemId: id,
      action: 'restored',
    ));
  }

  Future<void> moveItem(int id, int newLocationId, {int? oldLocationId}) async {
    await _db.transaction(() async {
      await _db.itemsDao.updateItem(
        ItemsCompanion(
          id: Value(id),
          locationId: Value(newLocationId),
          updatedAt: Value(DateTime.now()),
        )
      );

      await _db.itemHistoryDao.insertHistory(ItemHistoryCompanion.insert(
        itemId: id,
        action: 'moved',
        oldLocationId: Value(oldLocationId),
        newLocationId: Value(newLocationId),
        timestamp: Value(DateTime.now()),
      ));
    });
  }

  Future<void> deleteItem(int id) async {
    final item = await _db.itemsDao.getItem(id);
    final imagePath = item.imagePath;

    await _db.transaction(() async {
      // 1. Delete Reminders
      final history = await _db.itemHistoryDao.getHistoryForItem(id);
      for (var h in history) {
        await _db.itemHistoryDao.deleteHistory(h.id);
      }
      // 2. Delete Item
      await _db.itemsDao.deleteItem(id);
    });

    // 3. Cleanup Image File
    if (imagePath != null && imagePath.isNotEmpty) {
      try {
        final file = File(imagePath);
        if (await file.exists()) {
          await file.delete();
        }
      } catch (e) {
        // Ignore file deletion errors
      }
    }
  }
}
