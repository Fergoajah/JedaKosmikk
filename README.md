# 🚀 JedaKosmik

**JedaKosmik** adalah aplikasi mobile yang mengajak pengguna untuk menjelajahi keajaiban kosmos. Aplikasi ini menyajikan data dan gambar astronomi terbaru langsung dari berbagai API publik NASA, dibalut dalam antarmuka yang modern dan imersif.

## ✨ Fitur Utama

- 🔐 **Autentikasi Pengguna**: Sistem registrasi dan login yang aman menggunakan Firebase.
- 📡 **Data Real-time dari NASA**: Mengambil data dari berbagai API NASA, termasuk APOD, NEO, CME, dan Galeri Gambar.
- 🧭 **Navigasi Intuitif**: Perpindahan antar halaman yang mudah dengan Bottom Navigation Bar.
- 🖼️ **Galeri Interaktif**: Tampilan grid untuk galeri gambar yang responsif dengan fitur pencarian.
- 🧑‍🚀 **Profil Pengguna**: Halaman profil untuk mengelola akun dan melakukan logout.
- ⚠️ **Peringatan Asteroid**: Memberikan penanda visual untuk asteroid yang berpotensi berbahaya.

## 🛠️ Teknologi yang Digunakan

- [Flutter](https://flutter.dev/) - Framework UI untuk aplikasi multiplatform.
- [Dart](https://dart.dev/) - Bahasa pemrograman yang digunakan.
- [Firebase Authentication](https://firebase.google.com/products/auth) - Untuk sistem autentikasi pengguna.
- [NASA Open APIs](https://api.nasa.gov/) - Sebagai sumber utama data astronomi.
- Material Design 3 - Untuk desain antarmuka yang modern.

## 📸 Screenshot

*Catatan: Ganti placeholder di bawah ini dengan screenshot asli dari aplikasi Anda. Anda bisa menyimpannya di dalam folder `assets/screenshots/` di proyek Anda untuk kerapian.*

| Halaman Login | Halaman Utama | Halaman Explore | Halaman Detail |
| :---: | :---: | :---: | :---: |
| ![Login](https://placehold.co/300x600/0D1B2A/E0E1DD?text=Halaman+Login) | ![Home](https://placehold.co/300x600/0D1B2A/E0E1DD?text=Halaman+Utama) | ![Explore](https://placehold.co/300x600/0D1B2A/E0E1DD?text=Halaman+Explore) | ![Detail](https://placehold.co/300x600/0D1B2A/E0E1DD?text=Halaman+Detail) |

## ⚙️ Instalasi dan Konfigurasi

1.  **Clone repository ini**
    ```bash
    git clone [https://github.com/fergoajah/jedakosmikk.git](https://github.com/fergoajah/jedakosmikk.git)
    cd jedakosmik
    ```

2.  **Install dependensi Flutter**
    ```bash
    flutter pub get
    ```

3.  **Konfigurasi Firebase**
    - Buat proyek baru di [Firebase Console](https://console.firebase.google.com/).
    - Ikuti instruksi untuk menambahkan aplikasi Android/iOS ke proyek Firebase Anda.
    - Unduh file konfigurasi (`google-services.json` untuk Android) dan letakkan di direktori yang sesuai (`android/app/`).
    - Gunakan FlutterFire CLI untuk mengonfigurasi platform lain secara otomatis:
      ```bash
      flutterfire configure
      ```

4.  **Jalankan Aplikasi**
    ```bash
    flutter run
    ```
