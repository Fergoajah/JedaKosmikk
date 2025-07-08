## JedaKosmik 🚀
Selamat datang di JedaKosmik! Sebuah aplikasi seluler yang dibuat dengan Flutter untuk menjelajahi keajaiban kosmos. Aplikasi ini menyediakan berbagai informasi dan gambar astronomi yang diambil langsung dari API publik NASA. Pengguna dapat membuat akun, masuk, dan menelusuri alam semesta dari genggaman mereka.

## ✨ Fitur Utama
Autentikasi Pengguna: Sistem pendaftaran dan login yang aman dan mudah menggunakan Firebase Authentication.

Gambar Astronomi Hari Ini (APOD): Menampilkan gambar atau video astronomi pilihan NASA setiap hari, lengkap dengan penjelasan mendetail.

Perpustakaan Gambar & Video NASA: Cari gambar-gambar menakjubkan dari seluruh perpustakaan media NASA, seperti gambar dari Mars Rover, galaksi jauh, dan lainnya.

Objek Dekat Bumi (NEO): Lacak asteroid dan komet yang sedang atau akan mendekati orbit Bumi, lengkap dengan status potensi bahayanya.

Data Coronal Mass Ejection (CME): Dapatkan pembaruan tentang lontaran massa korona (badai matahari) dari Matahari.

Antarmuka yang Ramah Pengguna: Desain yang bersih dan intuitif dengan tema luar angkasa yang gelap untuk pengalaman yang imersif.

Multiplatform: Dibangun untuk berjalan di Android, iOS, dan platform lainnya yang didukung oleh Flutter.

## 🛠️ Teknologi & API yang Digunakan
Framework: Flutter

Bahasa: Dart

Backend & Autentikasi: Firebase Authentication

API:

NASA APOD (Astronomy Picture of the Day)

NASA Image and Video Library API

NASA DONKI (Database Of Notifications, Knowledge, Information) untuk data CME

NASA NeoWs (Near Earth Object Web Service)

Dependensi Utama:

http: Untuk melakukan panggilan jaringan ke API NASA.

firebase_core & firebase_auth: Untuk integrasi dan otentikasi Firebase.

provider: Untuk state management.

intl: Untuk pemformatan tanggal yang mudah dibaca.

## 🔧 Cara Menjalankan Proyek
Prasyarat
Pastikan Anda telah menginstal Flutter SDK.

Sebuah IDE seperti VS Code atau Android Studio.

Koneksi internet untuk mengambil data dari API.

Konfigurasi
Konfigurasi Firebase:

Proyek ini sudah dikonfigurasi untuk Firebase di platform Android dan Web.

Untuk menjalankannya, Anda perlu membuat proyek Firebase Anda sendiri dan mengganti file konfigurasi yang ada (android/app/google-services.json untuk Android dan lib/firebase_options.dart untuk semua platform). Ikuti panduan dari FlutterFire CLI.

Kunci API NASA:

Aplikasi ini menggunakan kunci API NASA demo. Sangat disarankan untuk mendapatkan kunci API gratis Anda sendiri dari api.nasa.gov untuk menghindari batas penggunaan.

Ganti kunci API di dalam file lib/api/nasa_api_service.dart dan lib/screens/home_screen.dart.

Instalasi & Menjalankan
Clone repositori:

git clone [https://github.com/fergoajah/jedakosmikk.git](https://github.com/fergoajah/jedakosmikk.git)
cd jedakosmik

Instal dependensi:

flutter pub get

Jalankan aplikasi:

flutter run

## 📂 Struktur Proyek
Struktur direktori utama dari proyek ini adalah sebagai berikut:

lib/
├── api/
│   └── nasa_api_service.dart      # Logika untuk berinteraksi dengan semua API NASA.
├── models/
│   ├── apod_model.dart            # Model data untuk APOD.
│   ├── cme_model.dart             # Model data untuk Coronal Mass Ejection.
│   ├── image_library_model.dart   # Model data untuk gambar dari NASA Library.
│   └── neo_model.dart             # Model data untuk Near-Earth Objects.
├── screens/
│   ├── home_screen.dart           # Halaman utama setelah login, menampilkan berbagai data.
│   ├── explore_screen.dart        # Halaman untuk mencari gambar di NASA Library.
│   ├── detail_screen.dart         # Halaman generik untuk menampilkan detail dari setiap item.
│   └── profile_screen.dart        # Halaman profil pengguna dan fungsi logout.
├── loginpage.dart                 # Halaman untuk login pengguna.
├── registerpage.dart              # Halaman untuk registrasi pengguna baru.
└── main.dart                      # Titik masuk utama aplikasi, menangani inisialisasi dan routing awal.
pubspec.yaml                       # File konfigurasi proyek dan dependensi.
