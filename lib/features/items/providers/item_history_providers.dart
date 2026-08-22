import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/database/providers/database_provider.dart';
import '../domain/item_history_model.dart';

final itemHistoryProvider = StreamProvider.family<List<ItemHistoryModel>, int>((ref, itemId) {
  final db = ref.watch(databaseProvider);
  
  return Rx.combineLatest2(
    db.itemHistoryDao.watchHistoryForItem(itemId),
    db.locationsDao.watchAllLocations(),
    (historyEntities, locations) {
      return historyEntities.map((e) {
        final oldLoc = locations.where((l) => l.id == e.oldLocationId).firstOrNull;
        final newLoc = locations.where((l) => l.id == e.newLocationId).firstOrNull;

        return ItemHistoryModel(
          id: e.id,
          itemId: e.itemId,
          action: e.action,
          oldLocationId: e.oldLocationId,
          oldLocationName: oldLoc?.name,
          newLocationId: e.newLocationId,
          newLocationName: newLoc?.name,
          createdAt: e.timestamp,
        );
      }).toList();
    }
  );
});
