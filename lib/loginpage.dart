import 'package:flutter/material.dart'; 
import 'package:firebase_auth/firebase_auth.dart'; 
import 'screens/home_screen.dart'; 
import 'registerpage.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Membuat instance dari FirebaseAuth untuk berinteraksi dengan layanan otentikasi Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Membuat controller untuk setiap TextField
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Variabel boolean untuk mengontrol visibilitas password
  bool _isPasswordVisible = false;

  // Fungsi asynchronous untuk menangani proses login pengguna
  Future<void> _login() async {
    try {
      // Memanggil metode signInWithEmailAndPassword dari FirebaseAuth.
      // Metode ini akan mencoba mengautentikasi pengguna dengan email dan password yang diberikan
      // .trim() digunakan untuk menghapus spasi di awal dan akhir teks
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Setelah login berhasil, periksa apakah widget masih ada di tree (mounted)
      // untuk menghindari error jika pengguna meninggalkan halaman saat proses async berjalan
      if (mounted) {
        // Navigasi ke HomeScreen dan mengganti halaman saat ini
        // sehingga pengguna tidak bisa kembali ke halaman login dengan tombol "back"
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      // Blok 'catch' untuk menangani error yang spesifik dari Firebase Auth
      
      String message;
      // Firebase Auth sekarang menggunakan kode 'invalid-credential' untuk email atau password yang salah
      if (e.code == 'invalid-credential') {
        message = 'Email atau password yang Anda masukkan salah.';
      } else {
        // Menangani kode error lainnya dengan pesan generik
        message = 'Terjadi kesalahan. Silakan coba lagi.';
      }

      // Jika widget masih ada, tampilkan pesan error menggunakan SnackBar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  // Metode dispose dipanggil saat widget dihapus dari tree
  // Digunakan untuk melepaskan resource yang digunakan oleh controller untuk mencegah memory leak
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Metode build yang merender UI dari halaman login
  @override
  Widget build(BuildContext context) {
    // Mendefinisikan warna-warna yang akan digunakan dalam UI untuk konsistensi
    const Color primaryTextColor = Color(0xFFE0E1DD);
    const Color secondaryTextColor = Color(0xFFE0E1DD);
    const Color buttonColor = Color(0xFF1B263B);

    // Scaffold adalah layout dasar untuk halaman Material Design
    return Scaffold(
      // Center menempatkan child-nya di tengah layar
      body: Center(
        // SingleChildScrollView memungkinkan konten untuk di-scroll jika ukurannya melebihi layar
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Menengahkan konten secara vertikal
            crossAxisAlignment: CrossAxisAlignment.stretch, // Merentangkan child agar selebar parent
            children: <Widget>[
              // Judul dan Subjudul Aplikasi
              const Text(
                'JedaKosmik',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: primaryTextColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Ambil Jeda Nikmati Kosmos',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: secondaryTextColor.withValues(alpha: 0.8),
                ),
              ),
              const SizedBox(height: 60),

              // Kolom Input Email
              TextField(
                controller: _emailController, // Menghubungkan controller ke TextField
                keyboardType: TextInputType.emailAddress, // Menampilkan keyboard khusus email
                decoration: InputDecoration(
                  labelText: 'Type Email Here',
                  labelStyle: TextStyle(color: secondaryTextColor.withValues(alpha: 0.7)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: secondaryTextColor.withValues(alpha: 0.5)),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: primaryTextColor),
                  ),
                ),
                style: const TextStyle(color: primaryTextColor),
              ),
              const SizedBox(height: 24),

              // Kolom Input Password
              TextField(
                controller: _passwordController, // Menghubungkan controller
                obscureText: !_isPasswordVisible, // Menyembunyikan teks jika _isPasswordVisible false
                decoration: InputDecoration(
                  labelText: 'Type Password Here',
                  labelStyle: TextStyle(color: secondaryTextColor.withValues(alpha: 0.7)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: secondaryTextColor.withValues(alpha: 0.5)),
                  ),

                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: primaryTextColor),
                  ),

                  // Menambahkan ikon di akhir TextField
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Mengubah ikon berdasarkan state _isPasswordVisible
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: secondaryTextColor.withValues(alpha: 0.7),
                    ),

                    // Saat ikon ditekan, ubah state visibilitas password
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                style: const TextStyle(color: primaryTextColor),
              ),

              const SizedBox(height: 48),

              // Tombol Login
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: _login, // Memanggil fungsi _login saat tombol ditekan
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 16, color: primaryTextColor),
                ),
              ),
              const SizedBox(height: 24),

              // Teks dan Tombol untuk Navigasi ke Halaman Register
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()),
                  );
                },
                child: Text(
                  'Belum ada roket? Register dulu',
                  style: TextStyle(color: secondaryTextColor.withValues(alpha: 0.8)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}