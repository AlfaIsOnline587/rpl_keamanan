// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:rpl_keamanan/models/user.dart';
import 'package:rpl_keamanan/main.dart';
import 'package:rpl_keamanan/repositories/user_repository.dart';

void main() {
  testWidgets('home opens the user list', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(userRepository: _FakeUserRepository()));

    await tester.tap(find.text('Lihat Pengguna'));
    await tester.pumpAndSettle();

    expect(find.text('Daftar Pengguna'), findsOneWidget);
    expect(find.text('Ayu Lestari'), findsOneWidget);
    expect(find.text('ayu@example.com'), findsOneWidget);
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
