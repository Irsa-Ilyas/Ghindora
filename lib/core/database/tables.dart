import 'package:drift/drift.dart';

@DataClassName('CategoryEntity')
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get icon => text()();
  TextColumn get color => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('LocationEntity')
class Locations extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  IntColumn get parentId => integer().nullable().references(Locations, #id)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('ItemEntity')
class Items extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  IntColumn get categoryId =>
      integer().nullable().references(Categories, #id)();
  IntColumn get locationId => integer().nullable().references(Locations, #id)();
  TextColumn get imagePath => text().nullable()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  BoolColumn get isImportant => boolean().withDefault(const Constant(false))();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('ItemHistoryEntity')
class ItemHistory extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get itemId => integer().references(Items, #id)();
  TextColumn get action => text()();
  IntColumn get oldLocationId =>
      integer().nullable().references(Locations, #id)();
  IntColumn get newLocationId =>
      integer().nullable().references(Locations, #id)();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('ReminderEntity')
class Reminders extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get itemId => integer().references(Items, #id)();
  TextColumn get title => text()();
  DateTimeColumn get dueDate => dateTime()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
