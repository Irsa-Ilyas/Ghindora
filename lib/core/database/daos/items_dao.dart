import 'package:drift/drift.dart';

import '../database.dart';
import '../tables.dart';

part 'items_dao.g.dart';

@DriftAccessor(tables: [Items, Categories, Locations])
class ItemsDao extends DatabaseAccessor<AppDatabase> with _$ItemsDaoMixin {
  ItemsDao(super.db);

  Future<List<ItemEntity>> getAllItems() => (select(items)..where((i) => i.isArchived.equals(false))).get();
  Stream<List<ItemEntity>> watchAllItems() => select(items).watch();
  Stream<List<ItemEntity>> watchActiveItems() => (select(items)..where((i) => i.isArchived.equals(false))).watch();
  Stream<List<ItemEntity>> watchArchivedItems() => (select(items)..where((i) => i.isArchived.equals(true))).watch();
  Stream<List<ItemEntity>> watchFavoriteItems() => (select(items)..where((i) => i.isFavorite.equals(true) & i.isArchived.equals(false))).watch();
  Stream<List<ItemEntity>> watchImportantItems() => (select(items)..where((i) => i.isImportant.equals(true) & i.isArchived.equals(false))).watch();
  
  Stream<List<ItemEntity>> watchRecentlyAdded() => (select(items)
        ..where((i) => i.isArchived.equals(false))
        ..orderBy([(i) => OrderingTerm(expression: i.createdAt, mode: OrderingMode.desc)])
        ..limit(10))
      .watch();

  Stream<List<ItemEntity>> watchRecentlyUpdated() => (select(items)
        ..where((i) => i.isArchived.equals(false))
        ..orderBy([(i) => OrderingTerm(expression: i.updatedAt, mode: OrderingMode.desc)])
        ..limit(10))
      .watch();
  Future<ItemEntity> getItem(int id) =>
      (select(items)..where((i) => i.id.equals(id))).getSingle();
  Future<int> insertItem(ItemsCompanion item) => into(items).insert(item);
  Future<bool> updateItem(ItemsCompanion item) => update(items).replace(item);
  Future<int> deleteItem(int id) =>
      (delete(items)..where((i) => i.id.equals(id))).go();
}
