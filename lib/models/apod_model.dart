// Kelas ini berfungsi sebagai "cetakan" atau "blueprint" untuk data yang diterima dari API Astronomy Picture of the Day (APOD) NASA
class ApodModel {
  // Properti final berarti nilainya tidak bisa diubah setelah objek dibuat
  // Ini memastikan data yang diterima dari API bersifat immutable (tidak berubah-ubah) di dalam aplikasi
  // Dan di bawah ini adalah parameter yang diperlukan untuk API dari APOD
  final String date; // param tanggal dari gambar
  final String explanation; // penjelasan tentang gambar
  final String? hdurl; // URL gambar versi HD
  final String mediaType; // tipe media misalnya gambar atau video
  final String title; // judul dari gambar 
  final String url; // URL gambar versi stander untuk thumbnail

  // Constructor standar untuk membuat objek ApodModel secara manual
  ApodModel({
    required this.date,
    required this.explanation,
    this.hdurl,
    required this.mediaType,
    required this.title,
    required this.url,
  });

  // Constructor 'fromJson' ini bertugas untuk mengubah data mentah dari API (dalam format Map<String, dynamic> menjadi objek ApodModel yang terstruktur
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