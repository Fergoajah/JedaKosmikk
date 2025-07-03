// lib/models/apod_model.dart

class ApodModel {
  final String date;
  final String explanation;
  final String? hdurl; // Bisa null jika media_type bukan image
  final String mediaType;
  final String title;
  final String url;

  ApodModel({
    required this.date,
    required this.explanation,
    this.hdurl,
    required this.mediaType,
    required this.title,
    required this.url,
  });

  // Factory constructor untuk membuat instance ApodModel dari JSON
  factory ApodModel.fromJson(Map<String, dynamic> json) {
    return ApodModel(
      date: json['date'],
      explanation: json['explanation'],
      hdurl: json['hdurl'],
      mediaType: json['media_type'],
      title: json['title'],
      url: json['url'],
    );
  }
}