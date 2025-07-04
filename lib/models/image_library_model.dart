// lib/models/image_library_model.dart

class ImageLibraryModel {
  final String title;
  final String description;
  final String nasaId;
  final String imageUrl;

  ImageLibraryModel({
    required this.title,
    required this.description,
    required this.nasaId,
    required this.imageUrl,
  });

  factory ImageLibraryModel.fromJson(Map<String, dynamic> json) {
    // Data utama ada di dalam list 'data'
    final data = json['data'][0];
    // Link gambar ada di dalam list 'links'
    final links = json['links'][0];

    return ImageLibraryModel(
      title: data['title'] ?? 'No Title',
      description: data['description'] ?? 'No Description',
      nasaId: data['nasa_id'] ?? '',
      imageUrl: links['href'] ?? '',
    );
  }
}