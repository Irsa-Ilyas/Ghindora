import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/providers/database_provider.dart';
import '../data/location_repository.dart';
import '../domain/location_model.dart';

final locationRepositoryProvider = Provider<LocationRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return LocationRepository(db);
});

final locationsProvider = StreamProvider<List<LocationModel>>((ref) {
  final repo = ref.watch(locationRepositoryProvider);
  return repo.watchAllLocations();
});
