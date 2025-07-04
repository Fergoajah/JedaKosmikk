import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/apod_model.dart';
import '../models/cme_model.dart';
import '../models/image_library_model.dart';
import '../models/neo_model.dart';

class DetailScreen extends StatelessWidget {
  final dynamic item;

  const DetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    if (item is CmeModel) {
      return _buildCmeDetail(context, item);
    } else if (item is ImageLibraryModel) {
      return _buildImageLibraryDetail(context, item);
    } else if (item is ApodModel) {
      return _buildApodDetail(context, item);
    } else if (item is NeoModel) {
      return _buildNeoDetail(context, item);
    } else {
      return Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: const Center(child: Text("Konten tidak dikenali.")),
      );
    }
  }

  // Tampilan Detail untuk Kabar Antariksa (CME)
  Widget _buildCmeDetail(BuildContext context, CmeModel cme) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      appBar: AppBar(
        title: const Text("Detail Kabar Antariksa"),
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFFE0E1DD),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // **PERBAIKAN:** Menghilangkan argumen 'context' yang tidak perlu
            _buildDetailRow("Waktu Mulai:", cme.startTime),
            const SizedBox(height: 16),
            const Text("Catatan Peristiwa:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFE0E1DD))),
            const SizedBox(height: 8),
            Text(
              cme.note ?? 'Tidak ada catatan.',
              style: const TextStyle(fontSize: 16, height: 1.5, color: Color(0xFFE0E1DD)),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }

  // Tampilan Detail untuk NASA Image Library
  Widget _buildImageLibraryDetail(BuildContext context, ImageLibraryModel image) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      appBar: AppBar(
        title: Text(image.title, overflow: TextOverflow.ellipsis),
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFFE0E1DD),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(image.imageUrl, width: double.infinity, fit: BoxFit.cover, errorBuilder: (c, e, s) => const Icon(Icons.error)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(image.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFE0E1DD))),
                  const SizedBox(height: 16),
                  const Divider(color: Colors.white24),
                  Text(image.description, style: const TextStyle(fontSize: 16, height: 1.5, color: Color(0xFFE0E1DD))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tampilan Detail untuk APOD
  Widget _buildApodDetail(BuildContext context, ApodModel apod) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      appBar: AppBar(
        title: Text(apod.title, overflow: TextOverflow.ellipsis),
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFFE0E1DD),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(apod.hdurl ?? apod.url, width: double.infinity, fit: BoxFit.cover, errorBuilder: (c, e, s) => const Icon(Icons.error)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(apod.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFE0E1DD))),
                  const SizedBox(height: 8),
                  Text(DateFormat.yMMMMd('id_ID').format(DateTime.parse(apod.date)), style: TextStyle(color: const Color(0xFFE0E1DD).withOpacity(0.7), fontSize: 16)),
                  const SizedBox(height: 16),
                  const Divider(color: Colors.white24),
                  Text(apod.explanation, style: const TextStyle(fontSize: 16, height: 1.5, color: Color(0xFFE0E1DD))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tampilan Detail untuk NEO (Asteroid)
  Widget _buildNeoDetail(BuildContext context, NeoModel neo) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      appBar: AppBar(
        title: Text(neo.name),
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFFE0E1DD),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Asteroid: ${neo.name}", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFE0E1DD))),
            const SizedBox(height: 16),
            const Divider(color: Colors.white24),
            _buildDetailRow("ID:", neo.id),
            _buildDetailRow("Estimasi Diameter Maksimal:", "${neo.estimatedDiameterMaxKm.toStringAsFixed(3)} km"),
            _buildDetailRow("Berpotensi Berbahaya:", neo.isPotentiallyHazardous ? "Ya" : "Tidak", valueColor: neo.isPotentiallyHazardous ? Colors.redAccent : Colors.green),
          ],
        ),
      ),
    );
  }
  
  // **PERBAIKAN:** Menghilangkan parameter 'context' yang tidak perlu
  Widget _buildDetailRow(String title, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFE0E1DD)))),
          Expanded(flex: 3, child: Text(value, style: TextStyle(fontSize: 16, color: valueColor ?? const Color(0xFFE0E1DD)))),
        ],
      ),
    );
  }
}