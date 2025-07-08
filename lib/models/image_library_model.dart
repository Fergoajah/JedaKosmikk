// Kelas ini berfungsi sebagai "cetakan" untuk setiap item yang diterima dari API NASA Image and Video Library
class ImageLibraryModel {
  final String title; // judul dari gambar
  final String description; // deskripsi dari gambar 
  final String nasaId; // ID yang diberikan nasa untuk aset ini
  final String imageUrl; // URL langsung ke file gambar

  // Constructor standar untuk membuat objek ImageLibraryModel
  ImageLibraryModel({
    required this.title,
    required this.description,
    required this.nasaId,
    required this.imageUrl,
  });

  // Factory constructor 'fromJson' untuk mengubah data mentah dari API (Map) menjadi objek ImageLibraryModel
  factory ImageLibraryModel.fromJson(Map<String, dynamic> json) {
    // Informasi utama seperti judul dan deskripsi berada di dalam list 'data'
    // Kita asumsikan kita selalu mengambil elemen pertama dari list tersebut ([0])
    final data = json['data'][0];
    // Informasi link gambar berada di dalam list 'links' yang terpisah
    final links = json['links'][0];

    // Mengembalikan instance baru dari ImageLibraryModel
    return ImageLibraryModel(
      title: data['title'] ?? 'No Title',
      description: data['description'] ?? 'No Description',
      nasaId: data['nasa_id'] ?? '',
      imageUrl: links['href'] ?? '',
    );
  }
}