// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminders_dao.dart';

// ignore_for_file: type=lint
mixin _$RemindersDaoMixin on DatabaseAccessor<AppDatabase> {
  $CategoriesTable get categories => attachedDatabase.categories;
  $LocationsTable get locations => attachedDatabase.locations;
  $ItemsTable get items => attachedDatabase.items;
  $RemindersTable get reminders => attachedDatabase.reminders;
  RemindersDaoManager get managers => RemindersDaoManager(this);
}

class RemindersDaoManager {
  final _$RemindersDaoMixin _db;
  RemindersDaoManager(this._db);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db.attachedDatabase, _db.categories);
  $$LocationsTableTableManager get locations =>
      $$LocationsTableTableManager(_db.attachedDatabase, _db.locations);
  $$ItemsTableTableManager get items =>
      $$ItemsTableTableManager(_db.attachedDatabase, _db.items);
  $$RemindersTableTableManager get reminders =>
      $$RemindersTableTableManager(_db.attachedDatabase, _db.reminders);
}
