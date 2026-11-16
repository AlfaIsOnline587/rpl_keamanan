import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rpl_keamanan/screens/validation_test_screen.dart';

void main() {
  testWidgets('form shows validation errors and accepts valid input', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: ValidationTestScreen()));

    await tester.tap(find.text('Periksa Input'));
    await tester.pumpAndSettle();

    expect(find.text('Nomor telepon tidak boleh kosong'), findsOneWidget);
    expect(find.text('URL tidak boleh kosong'), findsOneWidget);
    expect(find.text('Password tidak boleh kosong'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), '081234567890');
    await tester.enterText(
      find.byType(TextFormField).at(1),
      'https://example.com',
    );
    await tester.enterText(find.byType(TextFormField).at(2), 'Secure#123');
    await tester.tap(find.text('Periksa Input'));
    await tester.pumpAndSettle();

    expect(find.text('Semua input valid.'), findsOneWidget);
  });
}
