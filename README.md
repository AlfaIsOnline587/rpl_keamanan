# Manajemen Pengguna

Aplikasi Flutter sederhana untuk menampilkan daftar pengguna dari REST API.

## Konfigurasi

Secara default aplikasi menggunakan API demo JSONPlaceholder, sehingga dapat
langsung menampilkan daftar pengguna tanpa API key. Untuk memakai API lain,
atur file `.env`:

```env
BASE_URL=https://example.com/api
API_KEY=your-api-key
```

`API_KEY` opsional dan hanya dikirim jika nilainya diisi. Jangan masukkan
credential rahasia ke repositori publik.

## Menjalankan aplikasi

```bash
flutter pub get
flutter run
```

## Struktur `lib/`

- `config/`: konfigurasi aplikasi dan environment.
- `models/`: model serta serialisasi data.
- `repositories/`: kontrak dan implementasi akses data.
- `screens/`: halaman aplikasi.
- `services/`: komunikasi API dan penyimpanan aman.
- `utils/`: validasi dan sanitasi input.
- `widgets/`: komponen UI yang dapat digunakan ulang.
