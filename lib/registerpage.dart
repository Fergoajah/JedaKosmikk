import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/home_screen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Membuat instance dari FirebaseAuth untuk berinteraksi dengan layanan otentikasi Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Membuat controller untuk setiap TextField.
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Variabel boolean untuk mengontrol visibilitas password
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  // Fungsi asynchronous untuk menangani proses registrasi pengguna baru
  Future<void> _register() async {
    // Validasi konfirmasi password
    if (_passwordController.text.trim() !=
        _confirmPasswordController.text.trim()) {
      // Jika tidak cocok, tampilkan pesan error
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password dan konfirmasi password tidak cocok.'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
      return; // Hentikan proses registrasi
    }

    try {
      // Memanggil metode createUserWithEmailAndPassword dari FirebaseAuth
      // Metode ini akan membuat akun baru di Firebase Authentication
      // Await digunakan untuk menunggu hasil dari proses async di firebase
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Jika proses pembuatan user berhasil, cek apakah widget masih ada di tree (mounted)
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      // Blok 'catch' untuk menangani error yang spesifik dari Firebase Auth
      String message;
      // Memeriksa kode error yang dikembalikan oleh Firebase
      if (e.code == 'weak-password') {
        message = 'Password yang Anda masukkan terlalu lemah.';
      } else if (e.code == 'email-already-in-use') {
        message = 'Alamat email ini sudah terdaftar.';
      } else {
        message = 'Terjadi kesalahan. Silakan coba lagi.';
      }

      // Jika widget masih ada, tampilkan pesan error menggunakan SnackBar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
        );
      }
    }
  }

  // Metode dispose dipanggil saat widget dihapus dari tree
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Metode build yang merender UI dari halaman registrasi
  @override
  Widget build(BuildContext context) {
    // Mendefinisikan warna-warna yang akan digunakan dalam UI
    const Color primaryTextColor = Color(0xFFE0E1DD);
    const Color secondaryTextColor = Color(0xFFE0E1DD);
    const Color buttonColor = Color(0xFF1B263B);

    // Scaffold adalah layout dasar untuk halaman
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.transparent,
        elevation: 0,

        // Menambahkan tombol back secara manual
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryTextColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),

      // Center menempatkan child-nya di tengah
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Buat Akun',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: primaryTextColor,
                ),
              ),
              const SizedBox(height: 8),
              // Subjudul
              Text(
                'Bergabunglah dengan JedaKosmik',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: secondaryTextColor.withValues(alpha: 0.8),
                ),
              ),
              const SizedBox(height: 60),

              // TextField untuk Email
              TextField(
                controller: _emailController, // Menghubungkan dengan controller
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Type Email Here',
                  labelStyle: TextStyle(
                    color: secondaryTextColor.withValues(alpha: 0.7),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: secondaryTextColor.withValues(alpha: 0.5),
                    ),
                  ),
                ),
                style: const TextStyle(color: primaryTextColor),
              ),
              const SizedBox(height: 24),

              // TextField untuk Password
              TextField(
                controller:
                    _passwordController, // Menghubungkan dengan controller
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Type Password Here',
                  labelStyle: TextStyle(
                    color: secondaryTextColor.withValues(alpha: 0.7),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: secondaryTextColor.withValues(alpha: 0.5),
                    ),
                  ),

                  // Ikon untuk menampilkan/menyembunyikan password
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.lightbulb
                          : Icons.lightbulb_outlined,
                      color: secondaryTextColor.withValues(alpha: 0.7),
                    ),

                    onPressed: () {
                      // Mengubah state untuk me-render ulang UI dengan visibilitas password yang baru
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                style: const TextStyle(color: primaryTextColor),
              ),

              const SizedBox(height: 24),

              // TextField untuk Konfirmasi Password
              TextField(
                controller: _confirmPasswordController,
                obscureText: !_isConfirmPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Confirm Password Here',
                  labelStyle: TextStyle(color: secondaryTextColor.withValues(alpha: 0.7)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: secondaryTextColor.withValues(alpha: 0.5)),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible ? Icons.lightbulb : Icons.lightbulb_outlined,
                      color: secondaryTextColor.withValues(alpha: 0.7),
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                ),
                style: const TextStyle(color: primaryTextColor),
              ),

              const SizedBox(height: 48),

              // Tombol untuk registrasi
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed:
                    _register, // Memanggil fungsi _register saat tombol ditekan
                child: const Text(
                  'Register',
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
