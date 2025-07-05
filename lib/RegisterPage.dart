import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'screens/home_screen.dart'; // Untuk navigasi setelah berhasil

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // 1. Buat instance FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 2. Controller untuk mengambil teks dari input field
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  // 3. Fungsi utama untuk proses registrasi
  Future<void> _register() async {
    try {
      // Panggil metode untuk membuat user baru dengan email dan password
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(), // Ambil email dari controller
        password: _passwordController.text.trim(), // Ambil password dari controller
      );

      // Jika berhasil, arahkan pengguna ke halaman utama (HomeScreen)
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      // Tangani jika terjadi error saat registrasi
      String message;
      if (e.code == 'weak-password') {
        message = 'Password yang Anda masukkan terlalu lemah.';
      } else if (e.code == 'email-already-in-use') {
        message = 'Alamat email ini sudah terdaftar.';
      } else {
        message = 'Terjadi kesalahan. Silakan coba lagi.';
      }
      // Tampilkan pesan error kepada pengguna
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

  // Bersihkan controller saat widget tidak digunakan
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryTextColor = Color(0xFFE0E1DD);
    const Color secondaryTextColor = Color(0xFFE0E1DD);
    const Color buttonColor = Color(0xFF1B263B);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryTextColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
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
              Text(
                'Bergabunglah dengan JedaKosmik',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: secondaryTextColor.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 60),

              // TextField untuk Email, hubungkan dengan controller
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Type Email Here',
                  labelStyle: TextStyle(color: secondaryTextColor.withOpacity(0.7)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: secondaryTextColor.withOpacity(0.5)),
                  ),
                ),
                style: const TextStyle(color: primaryTextColor),
              ),
              const SizedBox(height: 24),

              // TextField untuk Password, hubungkan dengan controller
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Type Password Here',
                  labelStyle: TextStyle(color: secondaryTextColor.withOpacity(0.7)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: secondaryTextColor.withOpacity(0.5)),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: secondaryTextColor.withOpacity(0.7),
                    ),
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

              // Tombol untuk memanggil fungsi _register
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: _register, // 4. Panggil fungsi registrasi saat ditekan
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