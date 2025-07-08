import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../models/apod_model.dart';
import '../models/cme_model.dart'; 
import '../models/image_library_model.dart';
import '../models/neo_model.dart';

// Class ini bertanggung jawab untuk semua komunikasi dengan API NASA
// Ini membantu memisahkan logika pengambilan data dari logika tampilan (UI)
class NasaApiService {
  final String apiKey;
  // URL dasar untuk sebagian besar API NASA
  final String _baseUrl = "https://api.nasa.gov";
  // URL dasar khusus untuk API pencarian gambar dan video
  final String _imagesBaseUrl = "https://images-api.nasa.gov";

  // Constructor yang mewajibkan adanya API Key saat instance Class ini dibuat
  NasaApiService({required this.apiKey});

  // Fungsi untuk mengambil data Coronal Mass Ejection (CME) dari DONKI API
  Future<List<CmeModel>> fetchCmeData() async {
    // Membuat format tanggal yang sesuai dengan permintaan API (YYYY-MM-DD)
    final formatter = DateFormat('yyyy-MM-dd');
    // Menentukan tanggal akhir (hari ini)
    final String endDate = formatter.format(DateTime.now());
    // Menentukan tanggal mulai (30 hari yang lalu dari sekarang)
    final String startDate = formatter.format(DateTime.now().subtract(const Duration(days: 30)));
    
    // Melakukan permintaan GET ke endpoint CME dengan parameter tanggal dan API Key
    final response = await http.get(Uri.parse('$_baseUrl/DONKI/CME?startDate=$startDate&endDate=$endDate&api_key=$apiKey'));

    // Memeriksa apakah permintaan berhasil
    if (response.statusCode == 200) {
      // Mengubah body response (string JSON) menjadi List<dynamic>
      List<dynamic> body = jsonDecode(response.body);
      // Ubah setiap item dalam list body menjadi objek CmeModel, lalu kembalikan sebagai list baru berisi objek-objek CmeModel.
      return body.map((dynamic item) => CmeModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load CME data');
    }
  }

  // Fungsi untuk mencari gambar dari NASA Image and Video Library
  // Memiliki nilai default 'perseverance' untuk query jika tidak ada yang diberikan
  Future<List<ImageLibraryModel>> searchImages({String query = 'perseverance'}) async {
    // Melakukan permintaan GET ke endpoint pencarian gambar
    final response = await http.get(Uri.parse('$_imagesBaseUrl/search?q=$query&media_type=image'));
    if (response.statusCode == 200) {
      // Response dari API ini adalah sebuah Map (objek JSON)
      Map<String, dynamic> body = jsonDecode(response.body);
      // Data gambar yang sebenarnya berada di dalam 'collection' -> 'items'
      List<dynamic> items = body['collection']['items'];
       // Memetakan setiap item menjadi objek ImageLibraryModel
      return items.map((dynamic item) => ImageLibraryModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load images from NASA Library');
    }
  }
  
  // Fungsi untuk mengambil data Astronomy Picture of the Day (APOD)
  Future<List<ApodModel>> fetchApods({int count = 10}) async {
    // Melakukan permintaan GET ke endpoint APOD dengan parameter 'count' untuk mendapatkan beberapa gambar acak
    final response = await http.get(Uri.parse('$_baseUrl/planetary/apod?api_key=$apiKey&count=$count'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => ApodModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load APOD data');
    }
  }
  
   // Fungsi untuk mengambil data Near-Earth Objects (Asteroid yang mendekati Bumi)
  Future<List<NeoModel>> fetchNearEarthObjects() async {
    final formatter = DateFormat('yyyy-MM-dd');
    final String startDate = formatter.format(DateTime.now());
    final String endDate = formatter.format(DateTime.now().add(const Duration(days: 7)));

    // Melakukan permintaan GET ke endpoint NEO Feed
    final response = await http.get(Uri.parse('$_baseUrl/neo/rest/v1/feed?start_date=$startDate&end_date=$endDate&api_key=$apiKey'));
    
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      // Data NEO dikelompokkan berdasarkan tanggal dalam sebuah Map
      Map<String, dynamic> neoMap = body['near_earth_objects'];
      List<NeoModel> allNeos = [];
      // Melakukan iterasi pada setiap tanggal di dalam map
      neoMap.forEach((date, neoList) {
        // Melakukan iterasi pada setiap asteroid di dalam list untuk tanggal tersebut
        for (var neoJson in neoList) {
          // Menambahkan setiap asteroid ke dalam satu list gabungan
          allNeos.add(NeoModel.fromJson(neoJson));
        }
      });
      return allNeos;
    } else {
      throw Exception('Failed to load Near Earth Objects');
    }
  }
}