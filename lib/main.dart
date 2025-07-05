// lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jedakosmik/firebase_options.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'LoginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

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
        scaffoldBackgroundColor: const Color(0xFF0D1B2A),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  } // <--- PINDAHKAN KURUNG KURAWAL KE SINI
}