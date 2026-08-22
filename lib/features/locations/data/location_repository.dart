import 'package:drift/drift.dart';
import '../../../core/database/database.dart';
import '../domain/location_model.dart';

class LocationRepository {
  final AppDatabase _db;

  LocationRepository(this._db);

  Stream<List<LocationModel>> watchAllLocations() {
    return _db.locationsDao.watchAllLocations().map((entities) =>
        entities.map((e) => LocationModel.fromEntity(e)).toList());
  }

  Future<LocationModel> getLocation(int id) async {
    final entity = await _db.locationsDao.getLocation(id);
    return LocationModel.fromEntity(entity);
  }

  Future<int> addLocation(String name, {String? description, int? parentId}) async {
    return await _db.locationsDao.insertLocation(
      LocationsCompanion(
        name: Value(name),
        description: Value(description),
        parentId: Value(parentId),
      ),
    );
  }

  Future<bool> updateLocation(int id, String name, {String? description, int? parentId}) async {
    return await _db.locationsDao.updateLocation(
      LocationsCompanion(
        id: Value(id),
        name: Value(name),
        description: Value(description),
        parentId: Value(parentId),
      ),
    );
  }

  Future<int> deleteLocation(int id) async {
    // In a real app, you might want to handle cascading updates (e.g. set items locationId to null).
    return await _db.locationsDao.deleteLocation(id);
  }
}
