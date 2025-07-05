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
  final TextEditingController _searchController = TextEditingController();
  late final NasaApiService _apiService;
  Future<List<ImageLibraryModel>>? _searchResults;
  bool _isLoading = false;
  String? _lastSearchQuery;

  @override
  void initState() {
    super.initState();
    // Gunakan API Key yang sama seperti di HomeScreen
    const String yourNasaApiKey = "GhwQNqtjDGqQAhklmdPTsJNGzjLE74mxUvqSwg0C";
    _apiService = NasaApiService(apiKey: yourNasaApiKey);
  }

  void _performSearch(String query) {
    if (query.isNotEmpty) {
      setState(() {
        _isLoading = true;
        _lastSearchQuery = query;
        // Panggil API untuk mencari gambar
        _searchResults = _apiService.searchImages(query: query);
      });
      // Setelah future selesai, matikan loading state
      _searchResults!.whenComplete(() {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari gambar... (cth: Mars, Orion)',
                hintStyle: TextStyle(color: secondaryTextColor.withOpacity(0.5)),
                prefixIcon: const Icon(Icons.search, color: secondaryTextColor),
                filled: true,
                fillColor: const Color(0xFF1B263B),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: primaryTextColor),
              onSubmitted: _performSearch,
            ),
          ),
          // Hasil Pencarian
          Expanded(
            child: _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_searchResults == null) {
      return const Center(
        child: Text(
          'Mulai cari keajaiban kosmos.',
          style: TextStyle(color: Colors.white54, fontSize: 16),
        ),
      );
    }

    return FutureBuilder<List<ImageLibraryModel>>(
      future: _searchResults,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Gagal memuat hasil untuk "$_lastSearchQuery".\nCoba kata kunci lain.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white54),
            ),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'Tidak ada hasil ditemukan untuk "$_lastSearchQuery".',
              style: const TextStyle(color: Colors.white54),
            ),
          );
        }

        // Tampilkan hasil dalam GridView
        final items = snapshot.data!;
        return GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.8,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
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

  Widget _buildImageCard(ImageLibraryModel item) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black45,
          title: Text(
            item.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12),
          ),
        ),
        child: Image.network(
          item.imageUrl,
          fit: BoxFit.cover,
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