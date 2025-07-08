import 'package:flutter/material.dart';
import 'package:jedakosmik/api/nasa_api_service.dart';
import 'package:jedakosmik/models/image_library_model.dart';
import 'package:jedakosmik/screens/detail_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  // Controller untuk mengelola input teks di search bar
  final TextEditingController _searchController = TextEditingController();
  // Instance dari NasaApiService untuk melakukan panggilan API
  late final NasaApiService _apiService;
  // Variabel Future untuk menampung hasil pencarian yang akan datang dari API
  // Dibuat nullable (?) karena awalnya tidak ada hasil pencarian
  Future<List<ImageLibraryModel>>? _searchResults;
  // Flag untuk menandakan apakah proses pencarian sedang berlangsung (untuk menampilkan loading)
  bool _isLoading = false;
  // Menyimpan query pencarian terakhir untuk ditampilkan di pesan error/kosong
  String? _lastSearchQuery;

  // Metode initState dipanggil sekali saat widget pertama kali dibuat
  @override
  void initState() {
    super.initState();
    // Inisialisasi NasaApiService dengan API Key
    const String yourNasaApiKey = "GhwQNqtjDGqQAhklmdPTsJNGzjLE74mxUvqSwg0C";
    _apiService = NasaApiService(apiKey: yourNasaApiKey);
  }

  // Fungsi untuk memulai proses pencarian
  void _performSearch(String query) {
    // Hanya lakukan pencarian jika query tidak kosong
    if (query.isNotEmpty) {
      // Perbarui state untuk memulai UI loading
      setState(() {
        _isLoading = true;
        _lastSearchQuery = query;
        // Panggil metode searchImages dari API service dan simpan hasilnya di _searchResults
        _searchResults = _apiService.searchImages(query: query);
      });
      // Setelah future selesai (baik berhasil maupun gagal), hentikan state loading
      _searchResults!.whenComplete(() {
        // Pastikan widget masih ada di tree
        if (mounted) { 
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

  // Bersihkan controller saat widget tidak lagi digunakan untuk mencegah memory leak
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Metode build yang merender UI dari halaman explore
  @override
  Widget build(BuildContext context) {
    const Color primaryTextColor = Color(0xFFE0E1DD);
    const Color secondaryTextColor = Color(0xFFE0E1DD);

    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      appBar: AppBar(
        title: const Text(
          'Explore',
          style: TextStyle(
            color: primaryTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Widget untuk Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari gambar... (cth: Mars, Orion)',
                hintStyle: TextStyle(color: secondaryTextColor.withValues(alpha: 0.5)),
                prefixIcon: const Icon(Icons.search, color: secondaryTextColor),
                filled: true,
                fillColor: const Color(0xFF1B263B),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: primaryTextColor),

              // Panggil _performSearch saat pengguna menekan tombol "submit" di keyboard
              onSubmitted: _performSearch,
            ),
          ),

          // Widget untuk menampilkan hasil pencarian
          Expanded(
            child: _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  // Widget helper untuk build tampilan hasil pencarian
  Widget _buildSearchResults() {
    // Jika sedang loading, tampilkan indikator loading
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Jika _searchResults masih null (belum ada pencarian), tampilkan pesan awal
    if (_searchResults == null) {
      return const Center(
        child: Text(
          'Mulai cari keajaiban kosmos.',
          style: TextStyle(color: Colors.white54, fontSize: 16),
        ),
      );
    }

    // Gunakan FutureBuilder untuk memBuild UI berdasarkan state dari Future _searchResults
    return FutureBuilder<List<ImageLibraryModel>>(
      future: _searchResults,
      builder: (context, snapshot) {

        // Saat Future masih berjalan, tampilkan loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Jika terjadi error pada Future, tampilkan pesan error
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Gagal memuat hasil untuk "$_lastSearchQuery".\nCoba kata kunci lain.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white54),
            ),
          );
        }
        
        // Jika Future selesai tapi tidak ada data atau datanya kosong
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'Tidak ada hasil ditemukan untuk "$_lastSearchQuery".',
              style: const TextStyle(color: Colors.white54),
            ),
          );
        }

        // Jika data berhasil didapat, tampilkan dalam bentuk GridView
        final items = snapshot.data!;
        return GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Jumlah kolom
            crossAxisSpacing: 12, // Jarak Horizontal
            mainAxisSpacing: 12, // Jarak vertikal
            childAspectRatio: 0.8, // Rasio aspek item 
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];

            // Setiap item dibungkus GestureDetector agar bsia di klik
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(item: item),
                ),
              ),
              child: _buildImageCard(item),
            );
          },
        );
      },
    );
  }

  // Widget helper untuk membuild Card di dalam grid
  Widget _buildImageCard(ImageLibraryModel item) {

    // ClipRRect untuk border rounded pada Card
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),

      // Penggunaan widget gridtile untuk GridView
      child: GridTile(
        // Footer akan muncul di bagian bawah Card
        footer: GridTileBar(
          backgroundColor: Colors.black45,
          title: Text(
            item.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis, // Potong teks jika terlalu panjang
            style: const TextStyle(fontSize: 12),
          ),
        ),
        // Konten utama tile yaitu Gambar
        child: Image.network(
          item.imageUrl,
          fit: BoxFit.cover,  // Pastikan gambar memenuhi seluruh area Card
          // errorBuilder akan dipanggil jika gambar gagal dimuat
          errorBuilder: (c, e, s) => Container(
            color: const Color(0xFF1B263B),
            child: const Center(
              child: Icon(
                Icons.broken_image,
                color: Colors.white30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}