// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../api/nasa_api_service.dart';
import '../models/apod_model.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ApodModel>> futureApods;
  // --- PERHATIAN: GANTI DENGAN API KEY ANDA ---
  final String yourNasaApiKey = "GhwQNqtjDGqQAhklmdPTsJNGzjLE74mxUvqSwg0C"; 

  @override
  void initState() {
    super.initState();
    final apiService = NasaApiService(apiKey: yourNasaApiKey);
    futureApods = apiService.fetchApods(count: 15); // Ambil 15 item
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "JedaKosmik 🚀",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey[900],
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<ApodModel>>(
        future: futureApods,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada data ditemukan.'));
          } else {
            // Data berhasil didapatkan
            List<ApodModel> apods = snapshot.data!;
            return ListView.builder(
              itemCount: apods.length,
              itemBuilder: (context, index) {
                final apod = apods[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 4,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: Hero(
                      tag: apod.url, // Tag unik untuk animasi
                      child: Image.network(
                        apod.mediaType == 'image' ? apod.url : 'https://www.nasa.gov/wp-content/uploads/2023/08/nasa-logo-web-rgb.png', // Tampilkan logo nasa jika video
                        width: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 80),
                      ),
                    ),
                    title: Text(apod.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(DateFormat.yMMMMd('id_ID').format(DateTime.parse(apod.date))),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(apod: apod),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}