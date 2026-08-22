import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables.dart';
import 'daos/categories_dao.dart';
import 'daos/locations_dao.dart';
import 'daos/items_dao.dart';
import 'daos/item_history_dao.dart';
import 'daos/reminders_dao.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [Categories, Locations, Items, ItemHistory, Reminders],
  daos: [CategoriesDao, LocationsDao, ItemsDao, ItemHistoryDao, RemindersDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.addColumn(items, items.isImportant);
          await m.addColumn(items, items.isArchived);
        }
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'ghindora.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
