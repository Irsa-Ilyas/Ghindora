// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_history_dao.dart';

// ignore_for_file: type=lint
mixin _$ItemHistoryDaoMixin on DatabaseAccessor<AppDatabase> {
  $CategoriesTable get categories => attachedDatabase.categories;
  $LocationsTable get locations => attachedDatabase.locations;
  $ItemsTable get items => attachedDatabase.items;
  $ItemHistoryTable get itemHistory => attachedDatabase.itemHistory;
  ItemHistoryDaoManager get managers => ItemHistoryDaoManager(this);
}

class ItemHistoryDaoManager {
  final _$ItemHistoryDaoMixin _db;
  ItemHistoryDaoManager(this._db);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db.attachedDatabase, _db.categories);
  $$LocationsTableTableManager get locations =>
      $$LocationsTableTableManager(_db.attachedDatabase, _db.locations);
  $$ItemsTableTableManager get items =>
      $$ItemsTableTableManager(_db.attachedDatabase, _db.items);
  $$ItemHistoryTableTableManager get itemHistory =>
      $$ItemHistoryTableTableManager(_db.attachedDatabase, _db.itemHistory);
}
