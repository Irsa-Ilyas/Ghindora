import 'package:drift/drift.dart';

import '../database.dart';
import '../tables.dart';

part 'categories_dao.g.dart';

@DriftAccessor(tables: [Categories])
class CategoriesDao extends DatabaseAccessor<AppDatabase>
    with _$CategoriesDaoMixin {
  CategoriesDao(super.db);

  Future<List<CategoryEntity>> getAllCategories() => select(categories).get();
  Stream<List<CategoryEntity>> watchAllCategories() =>
      select(categories).watch();
  Future<CategoryEntity> getCategory(int id) =>
      (select(categories)..where((c) => c.id.equals(id))).getSingle();
  Future<int> insertCategory(CategoriesCompanion category) =>
      into(categories).insert(category);
  Future<bool> updateCategory(CategoriesCompanion category) =>
      update(categories).replace(category);
  Future<int> deleteCategory(int id) =>
      (delete(categories)..where((c) => c.id.equals(id))).go();
}
