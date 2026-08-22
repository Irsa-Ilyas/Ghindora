import 'package:drift/drift.dart';

import '../database.dart';
import '../tables.dart';

part 'reminders_dao.g.dart';

@DriftAccessor(tables: [Reminders])
class RemindersDao extends DatabaseAccessor<AppDatabase>
    with _$RemindersDaoMixin {
  RemindersDao(super.db);

  Future<List<ReminderEntity>> getRemindersForItem(int itemId) =>
      (select(reminders)..where((r) => r.itemId.equals(itemId))).get();

  Future<List<ReminderEntity>> getPendingReminders() =>
      (select(reminders)..where((r) => r.isCompleted.equals(false))).get();

  Future<int> insertReminder(RemindersCompanion reminder) =>
      into(reminders).insert(reminder);
  Future<bool> updateReminder(RemindersCompanion reminder) =>
      update(reminders).replace(reminder);
  Future<int> deleteReminder(int id) =>
      (delete(reminders)..where((r) => r.id.equals(id))).go();
}
