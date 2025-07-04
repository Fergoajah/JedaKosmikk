import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../models/apod_model.dart';
import '../models/cme_model.dart'; // Hanya gunakan model ini
import '../models/image_library_model.dart';
import '../models/neo_model.dart';

class NasaApiService {
  final String apiKey;
  final String _baseUrl = "https://api.nasa.gov";
  final String _imagesBaseUrl = "https://images-api.nasa.gov";

  NasaApiService({required this.apiKey});

  // FUNGSI UNTUK KABAR ANTARIKSA (YANG DIPERBAIKI)
  Future<List<CmeModel>> fetchCmeData() async {
    final formatter = DateFormat('yyyy-MM-dd');
    final String endDate = formatter.format(DateTime.now());
    final String startDate = formatter.format(DateTime.now().subtract(const Duration(days: 30)));
    
    final response = await http.get(Uri.parse('$_baseUrl/DONKI/CME?startDate=$startDate&endDate=$endDate&api_key=$apiKey'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => CmeModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load CME data');
    }
  }

  // --- FUNGSI LAINNYA (TETAP SAMA) ---
  Future<List<ImageLibraryModel>> searchImages({String query = 'nebula'}) async {
    final response = await http.get(Uri.parse('$_imagesBaseUrl/search?q=$query&media_type=image'));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> items = body['collection']['items'];
      return items.map((dynamic item) => ImageLibraryModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load images from NASA Library');
    }
  }
  
  Future<List<ApodModel>> fetchApods({int count = 10}) async {
    final response = await http.get(Uri.parse('$_baseUrl/planetary/apod?api_key=$apiKey&count=$count'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => ApodModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load APOD data');
    }
  }
  
  Future<List<NeoModel>> fetchNearEarthObjects() async {
    final formatter = DateFormat('yyyy-MM-dd');
    final String startDate = formatter.format(DateTime.now());
    final String endDate = formatter.format(DateTime.now().add(const Duration(days: 7)));
    final response = await http.get(Uri.parse('$_baseUrl/neo/rest/v1/feed?start_date=$startDate&end_date=$endDate&api_key=$apiKey'));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      Map<String, dynamic> neoMap = body['near_earth_objects'];
      List<NeoModel> allNeos = [];
      neoMap.forEach((date, neoList) {
        for (var neoJson in neoList) {
          allNeos.add(NeoModel.fromJson(neoJson));
        }
      });
      return allNeos;
    } else {
      throw Exception('Failed to load Near Earth Objects');
    }
  }
}