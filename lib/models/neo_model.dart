// lib/models/neo_model.dart

class NeoModel {
  final String id;
  final String name;
  final bool isPotentiallyHazardous;
  final double estimatedDiameterMaxKm; // Diameter dalam kilometer

  NeoModel({
    required this.id,
    required this.name,
    required this.isPotentiallyHazardous,
    required this.estimatedDiameterMaxKm,
  });

  factory NeoModel.fromJson(Map<String, dynamic> json) {
    return NeoModel(
      id: json['id'],
      name: json['name'],
      isPotentiallyHazardous: json['is_potentially_hazardous_asteroid'],
      estimatedDiameterMaxKm: json['estimated_diameter']['kilometers']['estimated_diameter_max'],
    );
  }
}