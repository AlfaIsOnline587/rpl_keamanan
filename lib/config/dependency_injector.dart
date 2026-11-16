import 'package:flutter/widgets.dart';

import '../repositories/post_repository.dart';
import '../repositories/post_repository_impl.dart';
import '../repositories/user_repository.dart';
import '../repositories/user_repository_impl.dart';
import '../services/api_service.dart';

/// Menyediakan dependency aplikasi melalui widget tree.
class DependencyInjector extends InheritedWidget {
  DependencyInjector({
    super.key,
    required super.child,
    UserRepository? userRepository,
    PostRepository? postRepository,
  }) : apiService = _sharedApiService,
       userRepository = userRepository ?? _sharedUserRepository,
       postRepository = postRepository ?? _sharedPostRepository;

  static final ApiService _sharedApiService = ApiService();
  static final UserRepository _sharedUserRepository = UserRepositoryImpl(
    _sharedApiService,
  );
  static final PostRepository _sharedPostRepository = PostRepositoryImpl(
    apiService: _sharedApiService,
  );

  final ApiService apiService;
  final UserRepository userRepository;
  final PostRepository postRepository;

  static DependencyInjector of(BuildContext context) {
    final injector = context
        .dependOnInheritedWidgetOfExactType<DependencyInjector>();
    if (injector == null) {
      throw FlutterError('DependencyInjector tidak ditemukan di widget tree.');
    }
    return injector;
  }

  @override
  bool updateShouldNotify(DependencyInjector oldWidget) =>
      apiService != oldWidget.apiService ||
      userRepository != oldWidget.userRepository ||
      postRepository != oldWidget.postRepository;
}
