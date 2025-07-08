import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jedakosmik/loginpage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Membuat instance dari FirebaseAuth untuk mengakses layanan otentikasi
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Variabel yang digunakan untuk menyipan informasi user yang sedang login
  User? _user;

  // Metode initState dipanggil sekali saat widget pertama kali dibuat
  @override
  void initState() {
    super.initState();
    // Mengambil informasi pengguna yang saat ini login dari FirebaseAuth dan menyimpannya di variabel _user
    _user = _auth.currentUser;
  }

  // Fungsi Asynchronus untuk menangani proses logout
  Future<void> _logout() async {
    // Memanggil metode signOut() untuk mengeluarkan pengguna dari session saat ini
    await _auth.signOut();
    // Cek apakah widget masih di dalam tree 
    if (mounted) {
      // Navigasi ke LoginPage dan menghapus semua halaman sebelumnya dari tumpukan navigasi
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        // Memastikan pengguna tidak bisa kembali ke halaman profil setelah logout
        (route) => false,
      );
    }
  }

  // Metode build yang merender UI dari halaman profil
  @override
  Widget build(BuildContext context) {
    const Color primaryTextColor = Color(0xFFE0E1DD);
    const Color buttonColor = Color(0xFF1B263B);

    // Scaffold menyediakan struktur dasar untuk halaman
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      appBar: AppBar(
        title: const Text(
          'Profil Pengguna',
          style: TextStyle(
            color: primaryTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      
      // Menempatkan semua konten di tengah layar
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

             // Widget untuk menampilkan avatar atau foto profil
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: buttonColor,
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: primaryTextColor,
                ),
              ),

              const SizedBox(height: 20),

               // Menampilkan email pengguna
              // `_user?.email` adalah null-aware operator, akan menampilkan email jika _user tidak null
              // `?? 'Tidak ada email'` adalah null-aware operator, akan menampilkan teks ini jika emailnya null
              Text(
                _user?.email ?? 'Tidak ada email',
                style: const TextStyle(
                  color: primaryTextColor,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 40),

              // Button untuk logout
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                ),
                // Memanggil fungsi `_logout` ketika button di-klik
                onPressed: _logout,
                child: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 16, color: primaryTextColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}