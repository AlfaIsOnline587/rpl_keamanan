# Manajemen Pengguna

Aplikasi Flutter sederhana untuk menampilkan daftar pengguna dari REST API.

## Konfigurasi

Secara default aplikasi menggunakan API demo JSONPlaceholder, sehingga dapat
langsung menampilkan daftar pengguna tanpa API key. Untuk memakai API lain,
atur konfigurasi saat menjalankan aplikasi:

```bash
flutter run --dart-define=BASE_URL=https://example.com/api --dart-define=API_KEY=your-non-secret-key
```

`API_KEY` opsional dan hanya dikirim jika nilainya diisi. Nilai
`--dart-define` tetap tertanam di aplikasi hasil build dan dapat diekstrak;
jangan gunakan untuk credential rahasia. Simpan key rahasia di backend/proxy.

## Menjalankan aplikasi

```bash
flutter pub get
flutter run
```

## Struktur `lib/`

- `config/`: konfigurasi API.
- `models/`: model serta serialisasi data.
- `repositories/`: kontrak dan implementasi akses data.
- `screens/`: halaman aplikasi.
- `services/`: komunikasi API dan penyimpanan aman.
- `utils/`: validasi dan sanitasi input.
- `widgets/`: komponen UI yang dapat digunakan ulang.
