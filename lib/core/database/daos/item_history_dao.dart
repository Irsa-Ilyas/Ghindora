import 'package:drift/drift.dart';

import '../database.dart';
import '../tables.dart';

part 'item_history_dao.g.dart';

@DriftAccessor(tables: [ItemHistory])
class ItemHistoryDao extends DatabaseAccessor<AppDatabase>
    with _$ItemHistoryDaoMixin {
  ItemHistoryDao(super.db);

  Future<List<ItemHistoryEntity>> getHistoryForItem(int itemId) =>
      (select(itemHistory)..where((h) => h.itemId.equals(itemId))).get();

  Stream<List<ItemHistoryEntity>> watchHistoryForItem(int itemId) =>
      (select(itemHistory)..where((h) => h.itemId.equals(itemId))
        ..orderBy([(h) => OrderingTerm(expression: h.timestamp, mode: OrderingMode.desc)]))
      .watch();

  Future<int> insertHistory(ItemHistoryCompanion history) =>
      into(itemHistory).insert(history);
  Future<int> deleteHistory(int id) =>
      (delete(itemHistory)..where((h) => h.id.equals(id))).go();
}
