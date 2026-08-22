class ItemHistoryModel {
  final int id;
  final int itemId;
  final String action;
  final int? oldLocationId;
  final String? oldLocationName;
  final int? newLocationId;
  final String? newLocationName;
  final DateTime createdAt;

  ItemHistoryModel({
    required this.id,
    required this.itemId,
    required this.action,
    this.oldLocationId,
    this.oldLocationName,
    this.newLocationId,
    this.newLocationName,
    required this.createdAt,
  });
}
