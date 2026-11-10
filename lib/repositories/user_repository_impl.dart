import '../models/user.dart';
import '../services/api_service.dart';
import 'user_repository.dart';

/// Implementasi konkret dari [UserRepository].
///
/// Class ini menggunakan [ApiService] untuk mengambil data dari API.
class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl([ApiService? apiService])
    : _apiService = apiService ?? ApiService();

  final ApiService _apiService;

  @override
  Future<List<User>> getUsers() => _apiService.getUsers();

  @override
  Future<User> getUserById(int id) {
    if (id <= 0) {
      throw ArgumentError.value(id, 'id', 'Harus berupa bilangan positif.');
    }
    return _apiService.getUserById(id);
  }

  /// Menutup resource yang digunakan.
  void dispose() {
    _apiService.dispose();
  }
}
