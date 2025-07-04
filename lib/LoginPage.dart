import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    // Definisikan warna dari palet
    const Color primaryTextColor = Color(0xFFE0E1DD);
    const Color secondaryTextColor = Color(0xFFE0E1DD);
    const Color buttonColor = Color(0xFF1B263B);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Judul dan Subjudul
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
                  color: secondaryTextColor.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 60),

              // Kolom Input Email
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Type Email Here',
                  labelStyle: TextStyle(color: secondaryTextColor.withOpacity(0.7)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: secondaryTextColor.withOpacity(0.5)),
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
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Type Password Here',
                  labelStyle: TextStyle(color: secondaryTextColor.withOpacity(0.7)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: secondaryTextColor.withOpacity(0.5)),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: primaryTextColor),
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

              // Tombol Login
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor, // Warna tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 16, color: primaryTextColor),
                ),
              ),
              const SizedBox(height: 24),

              // Teks untuk Register
              TextButton(
                onPressed: () {

                },
                child: Text(
                  'Belum ada roket? Register dulu',
                  style: TextStyle(color: secondaryTextColor.withOpacity(0.8)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}