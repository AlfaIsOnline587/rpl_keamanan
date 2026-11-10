import '../models/user.dart';

/// Abstraksi repository untuk mengelola data pengguna.
///
/// Interface ini mendefinisikan kontrak untuk operasi data pengguna.
/// Implementasi konkretnya ada di [UserRepositoryImpl].
abstract class UserRepository {
  /// Mengambil daftar semua pengguna.
  ///
  /// Melempar [Exception] jika terjadi error.
  Future<List<User>> getUsers();

  /// Mengambil pengguna berdasarkan [id].
  ///
  /// Parameter [id] harus berupa integer positif.
  Future<User> getUserById(int id);
}
