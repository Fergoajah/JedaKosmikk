// lib/models/cme_model.dart

class CmeModel {
  final String activityID;
  final String? note;
  final String startTime;

  CmeModel({required this.activityID, this.note, required this.startTime});

  factory CmeModel.fromJson(Map<String, dynamic> json) {
    return CmeModel(
      activityID: json['activityID'] ?? 'No ID',
      note: json['note'] ?? 'No note available.',
      startTime: json['startTime'] ?? '',
    );
  }
}