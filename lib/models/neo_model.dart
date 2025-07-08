// Kelas ini berfungsi sebagai "cetakan" untuk data Near-Earth Object (NEO) atau asteroid yang diterima dari API NASA
class NeoModel {
  final String id; // ID untuk setiap asteroid 
  final String name; // nama resmi dari asteroid
  final bool isPotentiallyHazardous; // boolean true/false untuk asteroid yuang berpotensi berbahaya
  final double estimatedDiameterMaxKm; // Diameter dalam kilometer

  // Constructor standar untuk membuat objek NeoModel
  NeoModel({
    required this.id,
    required this.name,
    required this.isPotentiallyHazardous,
    required this.estimatedDiameterMaxKm,
  });

  // Factory constructor 'fromJson' untuk mengubah data mentah dari API (Map) menjadi objek NeoModel
  factory NeoModel.fromJson(Map<String, dynamic> json) {
    return NeoModel(
      id: json['id'],
      name: json['name'],
      isPotentiallyHazardous: json['is_potentially_hazardous_asteroid'],
      // data bersarang di dalam json: json > estimated_diameter > kilometers > estimated_diameter_max
      estimatedDiameterMaxKm: json['estimated_diameter']['kilometers']['estimated_diameter_max'],
    );
  }
}