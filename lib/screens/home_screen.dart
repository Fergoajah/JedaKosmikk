import 'package:flutter/material.dart';
import 'package:jedakosmik/screens/detail_screen.dart';
import 'package:jedakosmik/screens/explore_screen.dart';
import 'package:jedakosmik/screens/profile_screen.dart';
import '../api/nasa_api_service.dart';
import '../models/apod_model.dart';
import '../models/cme_model.dart';
import '../models/image_library_model.dart';
import '../models/neo_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Variabel untuk menyimpan indeks tab yang sedang aktif
  int _selectedIndex = 0;

  // Daftar halaman yang akan ditampilkan
  static const List<Widget> _widgetOptions = <Widget>[
    HomeContent(),
    ExploreScreen(),
    ProfileScreen(),
  ];

  // Fungsi yang diapnggil ketika salah satu item tab dipilih
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      body: Center(
        // Menampilkan widget dari _widgetOptions sesuai dengan _selectedIndex
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      // BottomNavBar untuk menampilkan tab
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1B263B),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.rocket_launch), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.travel_explore), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: ''),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: const Color(0xFFE0E1DD).withValues(alpha: 0.7),
        onTap: _onItemTapped,
      ),
    );
  }
}

// Widget yang berisi konten dari halaman Home
// dipisahkan agar lebih mudaj ddikelola
class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  // Deklarasi service API dan Future untuk menampung hasil dari API
  late final NasaApiService apiService;
  late Future<List<ImageLibraryModel>> futureImages;
  late Future<List<CmeModel>> futureCme;
  late Future<List<ApodModel>> futureApod;
  late Future<List<NeoModel>> futureNeo;

  // initState dipanggil sekali saat widget pertama kali dibuat
  @override
  void initState() {
    super.initState();
    const String yourNasaApiKey = "GhwQNqtjDGqQAhklmdPTsJNGzjLE74mxUvqSwg0C";
    apiService = NasaApiService(apiKey: yourNasaApiKey);
    // Memulai proses pengambilan data dari API
    // Hasilnya disimpan dalam variabel Future
    futureImages = apiService.searchImages(query: 'perseverance');
    futureCme = apiService.fetchCmeData();
    futureApod = apiService.fetchApods(count: 10);
    futureNeo = apiService.fetchNearEarthObjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      appBar: AppBar(
        title: const Text(
          'JedaKosmik',
          style: TextStyle(
            color: Color(0xFFE0E1DD),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian Kabar dari MARS untuk API Images library NASA
            _buildSectionTitle('Kabar dari Mars'),
            _buildFeaturedImageSection(),

            const SizedBox(height: 20),
            // Bagian kategori kabar antariksa untuk API CME NASA
            _buildCategorySection<CmeModel>(
              title: 'Kabar Antariksa',
              future: futureCme,
              itemBuilder:
                  (item) => _buildTextOnlyCard(
                    title: 'Laporan Peristiwa',
                    content: item.note ?? 'Tidak ada catatan.',
                  ),
            ),
            // Bagian kategori Gambar Astronomi Hasi ini untuk API APOD NASA
            _buildCategorySection<ApodModel>(
              title: 'Gambar Astronomi Hari Ini',
              future: futureApod,
              itemBuilder:
                  (item) =>
                      _buildSmallCard(title: item.title, imageUrl: item.url),
            ),
            // Bagian kategori Asteroid untuk API NEO NASA
            _buildCategorySection<NeoModel>(
              title: 'Asteroid Mendekat',
              future: futureNeo,
              itemBuilder:
                  (item) => _buildSmallCard(
                    title: item.name,
                    imageUrl:
                        'https://s.w-x.co/util/image/w/in-asteroid_2.jpg?v=at&w=1280&h=720',
                    isHazardous: item.isPotentiallyHazardous,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk membuat kartu yang hanya berisi teks untuk kategori Kabar Antariksa, namun bisa digunakan oleh kategori manapun jika diperlukan
  Widget _buildTextOnlyCard({required String title, required String content}) {
    return Container(
      width: 180,
      height: 150,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1B263B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFFE0E1DD),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              content,
              style: TextStyle(
                color: const Color(0xFFE0E1DD).withValues(alpha: 0.8),
                fontSize: 12,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // Widget generik untuk membuat sebuah section kategori dengan list horizontal
  Widget _buildCategorySection<T>({
    required String title,
    required Future<List<T>> future,
    required Widget Function(T item) itemBuilder,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        SizedBox(
          height: 150,
          // FutureBuilder membangun UI berdasarkan state dari sebuah Future
          child: FutureBuilder<List<T>>(
            future: future,
            builder: (context, snapshot) {
              // Menampilkan indikator loading ketika data sedang diambil
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              // Menampilkan pesan error ketika ada error atau tidak ada data
              if (snapshot.hasError ||
                  !snapshot.hasData ||
                  snapshot.data!.isEmpty) {
                return const Center(
                  child: Text(
                    'Data tidak tersedia',
                    style: TextStyle(color: Colors.white54),
                  ),
                );
              }
              // Jika data berhasil didapat, bangun ListView
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data![index];
                  // GestureDetector untuk membuat item bisa ditekan atau di tap
                  return GestureDetector(
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(item: item),
                          ),
                        ),
                    child: itemBuilder(item),
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // Widget untuk membangun Card kecil dengan gambar dan judul
  Widget _buildSmallCard({
    required String title,
    required String imageUrl,
    String? subtitle,
    bool isHazardous = false, // penanda warning untuk asteroid berbahaya
  }) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (c, e, s) => Container(
                          color: const Color(0xFF1B263B),
                          child: const Center(
                            child: Icon(
                              Icons.broken_image,
                              color: Colors.white30,
                            ),
                          ),
                        ),
                  ),
                  // Menampilkan ikon peringantan jika asteroid berbahaya
                  if (isHazardous)
                    const Positioned(
                      top: 8,
                      right: 8,
                      child: Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.redAccent,
                        size: 20,
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFFE0E1DD),
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (subtitle != null)
            Text(
              subtitle,
              style: TextStyle(
                color: const Color(0xFFE0E1DD).withValues(alpha: 0.7),
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }

  // Widget untuk membangun section gambar unggulana atau bagian paling atas yaitu Kabar dari MARS
  Widget _buildFeaturedImageSection() {
    return SizedBox(
      height: 180,
      child: FutureBuilder<List<ImageLibraryModel>>(
        future: futureImages,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Gagal memuat gambar',
                style: TextStyle(color: Colors.white54),
              ),
            );
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            // Batasi jumlah item yang ditampilkan untuk performa
            itemCount: snapshot.data!.length > 10 ? 10 : snapshot.data!.length,
            itemBuilder: (context, index) {
              final item = snapshot.data![index];
              return GestureDetector(
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(item: item),
                      ),
                    ),
                child: _buildFeaturedCard(
                  title: item.title,
                  imageUrl: item.imageUrl,
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Widget untuk build CArd besar untuk gambar unggulan
  Widget _buildFeaturedCard({
    required String title,
    String? subtitle,
    required String imageUrl,
  }) {
    return Container(
      width: 280,
      height: 160,
      margin: const EdgeInsets.only(right: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder:
                  (c, e, s) => const Center(
                    child: Icon(
                      Icons.satellite_alt_rounded,
                      color: Colors.white30,
                      size: 50,
                    ),
                  ),
            ),
            // Gradient hitam di bagian bawah card untuk membuat teks lebih mudah dibaca
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.8),
                  ],
                  stops: const [0.5, 1.0],
                ),
              ),
            ),
            // Posisi teks di bagian bawah kartu
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      shadows: [Shadow(blurRadius: 2, color: Colors.black54)],
                    ),
                  ),
                  if (subtitle != null && subtitle.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        subtitle,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget helper untuk membuat judul section
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFFE0E1DD),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
