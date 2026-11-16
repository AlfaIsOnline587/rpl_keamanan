// read only - awal
import '../models/post.dart';
import '../services/api_service.dart';
import 'post_repository.dart';

/// Implementasi konkret dari [PostRepository] yang memakai [ApiService].
class PostRepositoryImpl implements PostRepository {
  PostRepositoryImpl({ApiService? apiService})
    : _apiService = apiService ?? ApiService();

  final ApiService _apiService;

  @override
  Future<List<Post>> getPosts() => _apiService.getPosts();
}
// read only - akhir
