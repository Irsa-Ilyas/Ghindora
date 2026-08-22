import 'package:drift/drift.dart';

import '../database.dart';
import '../tables.dart';

part 'locations_dao.g.dart';

@DriftAccessor(tables: [Locations])
class LocationsDao extends DatabaseAccessor<AppDatabase>
    with _$LocationsDaoMixin {
  LocationsDao(super.db);

  Future<List<LocationEntity>> getAllLocations() => select(locations).get();
  Stream<List<LocationEntity>> watchAllLocations() => select(locations).watch();
  Future<LocationEntity> getLocation(int id) =>
      (select(locations)..where((l) => l.id.equals(id))).getSingle();
  Future<int> insertLocation(LocationsCompanion location) =>
      into(locations).insert(location);
  Future<bool> updateLocation(LocationsCompanion location) =>
      update(locations).replace(location);
  Future<int> deleteLocation(int id) =>
      (delete(locations)..where((l) => l.id.equals(id))).go();
}
