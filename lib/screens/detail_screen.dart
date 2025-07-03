// lib/screens/detail_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/apod_model.dart';

class DetailScreen extends StatelessWidget {
  final ApodModel apod;

  const DetailScreen({super.key, required this.apod});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(apod.title, overflow: TextOverflow.ellipsis),
        backgroundColor: Colors.blueGrey[900],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tampilkan gambar atau placeholder untuk video
              if (apod.mediaType == 'image')
                Hero(
                  tag: apod.url, // Tag yang sama dengan di home_screen
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      apod.hdurl ?? apod.url, // Prioritaskan gambar HD
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.satellite_alt_rounded, size: 150),
                    ),
                  ),
                )
              else
                // Jika video, tampilkan pesan
                Container(
                  height: 200,
                  color: Colors.black,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.videocam, color: Colors.white, size: 50),
                      const SizedBox(height: 10),
                      const Text(
                        "Konten ini adalah video.",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          // TODO: Tambahkan fungsi untuk membuka URL video di browser
                        },
                        child: const Text("Buka di Browser"),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 20),

              // Judul Berita
              Text(
                apod.title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              // Tanggal
              Text(
                DateFormat.yMMMMd('id_ID').format(DateTime.parse(apod.date)),
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),

              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 16),

              // Penjelasan
              Text(
                apod.explanation,
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}