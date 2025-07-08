# 🚀 JedaKosmik

**JedaKosmik** adalah aplikasi mobile yang mengajak pengguna untuk menjelajahi keajaiban kosmos. Aplikasi ini menyajikan data dan gambar astronomi terbaru langsung dari berbagai API publik NASA, dibalut dalam antarmuka yang modern dan imersif.

## ✨ Fitur Utama

- 🔐 **Autentikasi Pengguna**: Sistem registrasi dan login yang aman menggunakan Firebase.
- 📡 **Data Real-time dari NASA**: Mengambil data dari berbagai API NASA, termasuk APOD, NEO, CME, dan Galeri Gambar.
- 🧭 **Navigasi Intuitif**: Perpindahan antar halaman yang mudah dengan Bottom Navigation Bar.
- 🖼️ **Galeri Interaktif**: Tampilan grid untuk galeri gambar yang responsif dengan fitur pencarian.
- 🧑‍🚀 **Profil Pengguna**: Halaman profil untuk melakukan logout.
- ⚠️ **Peringatan Asteroid**: Memberikan penanda visual untuk asteroid yang berpotensi berbahaya.

## 🛠️ Teknologi yang Digunakan

- [Flutter](https://flutter.dev/) - Framework UI untuk aplikasi multiplatform.
- [Dart](https://dart.dev/) - Bahasa pemrograman yang digunakan.
- [Firebase Authentication](https://firebase.google.com/products/auth) - Untuk sistem autentikasi pengguna.
- [NASA Open APIs](https://api.nasa.gov/) - Sebagai sumber utama data astronomi.
- Material Design 3 - Untuk desain antarmuka yang modern.

## 📸 Screenshot

| Halaman Login | Halaman Utama | Halaman Explore | Halaman Detail |
| :---: | :---: | :---: | :---: |
| ![Screenshot_2025-07-08-10-03-56-266_com example jedakosmik](https://github.com/user-attachments/assets/c17f91a1-6446-41b4-b337-2f132ab1255e) | ![Screenshot_2025-07-08-10-04-55-168_com example jedakosmik](https://github.com/user-attachments/assets/151ba174-f4ea-4d0d-b6b2-639830e68cea) | ![Screenshot_2025-07-08-10-05-28-097_com example jedakosmik](https://github.com/user-attachments/assets/9b525fa6-a70d-40ce-9800-becb5caafa98) | ![Screenshot_2025-07-08-10-04-50-453_com example jedakosmik](https://github.com/user-attachments/assets/d8c9db0e-6af6-44de-a3ca-17f3cc88cb6f) |

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
