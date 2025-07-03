// lib/api/nasa_api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/apod_model.dart';

class NasaApiService {
  final String apiKey;
  final String _baseUrl = "https://api.nasa.gov/planetary/apod";

  NasaApiService({required this.apiKey});

  // Fungsi untuk mengambil beberapa gambar/berita sekaligus
  // NASA APOD API mengizinkan parameter 'count' untuk mengambil data random
  Future<List<ApodModel>> fetchApods({int count = 10}) async {
    final response = await http.get(Uri.parse('$_baseUrl?api_key=$apiKey&count=$count'));

    if (response.statusCode == 200) {
      // Jika request berhasil
      List<dynamic> body = jsonDecode(response.body);
      List<ApodModel> apods = body.map((dynamic item) => ApodModel.fromJson(item)).toList();
      return apods;
    } else {
      // Jika gagal, lemparkan error
      throw Exception('Failed to load APOD data');
    }
  }
}