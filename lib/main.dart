// lib/main.dart

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'screens/home_screen.dart';

void main() async {
  // Pastikan binding Flutter sudah siap
  WidgetsFlutterBinding.ensureInitialized();
  // Inisialisasi locale untuk format tanggal Indonesia
  await initializeDateFormatting('id_ID', null);
  
  runApp(const JedaKosmikApp());
}

class JedaKosmikApp extends StatelessWidget {
  const JedaKosmikApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JedaKosmik',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}