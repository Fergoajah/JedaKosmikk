import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/apod_model.dart';
import '../models/cme_model.dart';
import '../models/image_library_model.dart';
import '../models/neo_model.dart';

// DetailScreen bersifat stateless karena tampilannya ditentukan berdasrakan item yang dipilih
class DetailScreen extends StatelessWidget {
  // Properti item bersifat dynamic karena DetailScreen menerima berbagai jenis model data
  final dynamic item;

  // Constructor untuk menerima data 'item' yang akan ditampilkan
  const DetailScreen({super.key, required this.item});

  // Metode build utama yang akan menentukan tampilan mana yang harus dirender
  @override
  Widget build(BuildContext context) {
    // Menggunakan serangkaian 'if-else if' untuk memeriksa tipe data dari 'item'
    if (item is CmeModel) {
      return _buildCmeDetail(context, item);
    } else if (item is ImageLibraryModel) {
      return _buildImageLibraryDetail(context, item);
    } else if (item is ApodModel) {
      return _buildApodDetail(context, item);
    } else if (item is NeoModel) {
      return _buildNeoDetail(context, item);
    } else {
       // Jika tipe item tidak dikenali, tampilkan halaman error
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
            // Memanggil widget helper untuk menampilkan baris informasi
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
            // Menampilkan gambar utama dari URL
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
            // Menampilkan gambar HD jika tersedia, jika tidak, gunakan URL standar
            Image.network(apod.hdurl ?? apod.url, width: double.infinity, fit: BoxFit.cover, errorBuilder: (c, e, s) => const Icon(Icons.error)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(apod.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFE0E1DD))),

                  const SizedBox(height: 8),

                  // Memformat dan menampilkan tanggal sesuai lokal Indonesia
                  Text(DateFormat.yMMMMd('id_ID').format(DateTime.parse(apod.date)), style: TextStyle(color: const Color(0xFFE0E1DD).withValues(alpha: 0.7), fontSize: 16)),
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

            // Menggunakan widget helper untuk menampilkan informasi secara konsisten
            _buildDetailRow("ID:", neo.id),
            _buildDetailRow("Estimasi Diameter Maksimal:", "${neo.estimatedDiameterMaxKm.toStringAsFixed(3)} km"),
            // Memberikan warna berbeda pada nilai berdasarkan status bahaya
            _buildDetailRow("Berpotensi Berbahaya:", neo.isPotentiallyHazardous ? "Ya" : "Tidak", valueColor: neo.isPotentiallyHazardous ? Colors.redAccent : Colors.green),
          ],
        ),
      ),
    );
  }
  
  // Widget helper yang bisa digunakan kembali untuk membuat baris detail
  // Ini membantu mengurangi duplikasi kode dan menjaga konsistensi tampilan
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