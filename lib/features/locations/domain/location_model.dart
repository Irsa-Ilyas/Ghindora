class LocationModel {
  final int id;
  final String name;
  final String? description;
  final int? parentId;
  final DateTime createdAt;

  const LocationModel({
    required this.id,
    required this.name,
    this.description,
    this.parentId,
    required this.createdAt,
  });

  factory LocationModel.fromEntity(dynamic entity) {
    return LocationModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      parentId: entity.parentId,
      createdAt: entity.createdAt,
    );
  }

  LocationModel copyWith({
    int? id,
    String? name,
    String? description,
    int? parentId,
    DateTime? createdAt,
  }) {
    return LocationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      parentId: parentId ?? this.parentId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
