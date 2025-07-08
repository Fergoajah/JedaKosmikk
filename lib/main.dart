import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:jedakosmik/firebase_options.dart'; 
import 'package:intl/date_symbol_data_local.dart'; 
import 'package:jedakosmik/screens/home_screen.dart';
import 'loginpage.dart';

// Fungsi utama (main) yang akan dieksekusi pertama kali saat aplikasi dijalankan
void main() async {
  // Memastikan semua binding Flutter sudah siap sebelum menjalankan kode lain
  WidgetsFlutterBinding.ensureInitialized();
  
  // Menginisialisasi format tanggal untuk lokal Indonesia ('id_ID')
  await initializeDateFormatting('id_ID', null);

  // Menginisialisasi Firebase di aplikasi menggunakan konfigurasi default untuk platform
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Menjalankan aplikasi dengan me-render widget utama, yaitu JedaKosmikApp
  runApp(const JedaKosmikApp());
}

// Widget utama (root widget) dari aplikasi
// Merupakan StatelessWidget karena konfigurasinya tidak berubah selama runtime
class JedaKosmikApp extends StatelessWidget {
  const JedaKosmikApp({super.key});

  // Metode build bertanggung jawab untuk membuat dan mengembalikan hierarki widget
  @override
  Widget build(BuildContext context) {
    // MaterialApp adalah widget dasar untuk aplikasi yang menggunakan Material Design
    return MaterialApp(
      title: 'JedaKosmik', // Judul aplikasi yang muncul di task manager perangkat
      theme: ThemeData(
        // Mengatur skema warna aplikasi
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // Mengatur warna latar belakang default untuk semua scaffold
        scaffoldBackgroundColor: const Color(0xFF0D1B2A),
        // Mengaktifkan penggunaan Material You (Material 3)
        useMaterial3: true,
      ),
      // Menghilangkan banner "DEBUG" di pojok kanan atas layar
      debugShowCheckedModeBanner: false,
      // Widget yang akan ditampilkan pertama kali yaitu AuthGate, dimana jika user sudah login maka akan diarahkan ke HomeScreen
      home: const AuthGate(), 
    );
  }
}


// Widget baru yang berfungsi sebagai "pintu gerbang" otentikasi
// Tujuannya adalah untuk memeriksa status login pengguna dan mengarahkannya ke halaman yang sesuai.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    // StreamBuilder adalah widget yang akan membangun dirinya sendiri berdasarkan data terbaru dari sebuah Stream
    return StreamBuilder<User?>(
      // 'stream' yang didengarkan adalah status perubahan otentikasi dari FirebaseAuth
      // Stream ini akan mengirimkan objek 'User' jika login, atau 'null' jika logout
      stream: FirebaseAuth.instance.authStateChanges(),
      // 'builder' adalah fungsi yang akan dipanggil setiap kali ada data baru dari stream
      builder: (context, snapshot) {
        // Cek 1: Jika koneksi ke stream masih dalam proses loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Tampilkan indikator loading di tengah layar
          return const Center(child: CircularProgressIndicator());
        }

        // Cek 2: Jika stream sudah memiliki data
        // Ini berarti objek 'User' tidak null, artinya pengguna sudah login
        if (snapshot.hasData) {
          // Arahkan pengguna langsung ke HomeScreen
          return const HomeScreen(); 
        }

        // Cek 3: Jika tidak ada dalam kondisi di atas (snapshot tidak punya data)
        // Ini berarti pengguna belum login
        return const LoginPage(); // Tampilkan halaman login
      },
    );
  }
}