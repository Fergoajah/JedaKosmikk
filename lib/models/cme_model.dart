// Kelas ini berfungsi sebagai "cetakan" atau "blueprint" untuk data yang diterima dari API Coronal Mass Ejection (CME) NASA
class CmeModel {
  final String activityID; // ID untuk setiap berita pada CME
  final String? note; // catatatn tentang peristiwa CME
  final String startTime; // waktuu dimulainya peristiwa CME

  // Constructor standar untuk membuat objek CmeModel secara manual
  CmeModel({
    required this.activityID, 
    this.note, 
    required this.startTime
    }
  );

  // Factory constructor 'fromJson' untuk mengubah data mentah dari API (Map) menjadi objek CmeModel
  factory CmeModel.fromJson(Map<String, dynamic> json) {
    return CmeModel(
      activityID: json['activityID'] ?? 'No ID',
      note: json['note'] ?? 'No note available.',
      startTime: json['startTime'] ?? '',
    );
  }
}
