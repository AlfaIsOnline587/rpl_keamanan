// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rpl_keamanan/config/dependency_injector.dart';
import 'package:rpl_keamanan/models/post.dart';
import 'package:rpl_keamanan/models/user.dart';
import 'package:rpl_keamanan/main.dart';
import 'package:rpl_keamanan/repositories/post_repository.dart';
import 'package:rpl_keamanan/repositories/user_repository.dart';
import 'package:rpl_keamanan/screens/post_list_screen.dart';

void main() {
  test('dependencies reuse the singleton API service and repositories', () {
    final first = DependencyInjector(child: const SizedBox());
    final second = DependencyInjector(child: const SizedBox());

    expect(identical(first.apiService, second.apiService), isTrue);
    expect(identical(first.userRepository, second.userRepository), isTrue);
    expect(identical(first.postRepository, second.postRepository), isTrue);
  });

  testWidgets('home opens the user list', (WidgetTester tester) async {
    await tester.pumpWidget(
      DependencyInjector(
        userRepository: _FakeUserRepository(),
        child: const MyApp(),
      ),
    );

    await tester.tap(find.text('Lihat Pengguna'));
    await tester.pumpAndSettle();

    expect(find.text('Daftar Pengguna'), findsOneWidget);
    expect(find.text('Ayu Lestari'), findsOneWidget);
    expect(find.text('ayu@example.com'), findsOneWidget);
  });

  testWidgets('user list hides unexpected error details', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      DependencyInjector(
        userRepository: _FailingUserRepository(),
        child: const MyApp(),
      ),
    );
    await tester.tap(find.text('Lihat Pengguna'));
    await tester.pumpAndSettle();

    expect(
      find.textContaining('Terjadi kesalahan. Silakan coba lagi nanti.'),
      findsOneWidget,
    );
    expect(find.textContaining('private internal details'), findsNothing);
  });

  testWidgets('post list hides unexpected error details', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      DependencyInjector(
        postRepository: _FailingPostRepository(),
        child: const MaterialApp(home: PostListScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.textContaining('Terjadi kesalahan. Silakan coba lagi nanti.'),
      findsOneWidget,
    );
    expect(find.textContaining('private internal details'), findsNothing);
  });
}

class _FakeUserRepository implements UserRepository {
  @override
  Future<List<User>> getUsers() async => const [
    User(id: 1, name: 'Ayu Lestari', email: 'ayu@example.com'),
  ];

  @override
  Future<User> getUserById(int id) async =>
      const User(id: 1, name: 'Ayu Lestari', email: 'ayu@example.com');
}

class _FailingUserRepository implements UserRepository {
  @override
  Future<List<User>> getUsers() async {
    throw Exception('private internal details');
  }

  @override
  Future<User> getUserById(int id) async {
    throw Exception('private internal details');
  }
}

class _FailingPostRepository implements PostRepository {
  @override
  Future<List<Post>> getPosts() async {
    throw Exception('private internal details');
  }
}
