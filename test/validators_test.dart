import 'package:flutter_test/flutter_test.dart';
import 'package:rpl_keamanan/utils/validators.dart';

void main() {
  group('Validators.validatePhone', () {
    test('accepts 10 and 13 digits', () {
      expect(Validators.validatePhone('0123456789'), isNull);
      expect(Validators.validatePhone('0123456789012'), isNull);
    });

    test('rejects invalid length and non-digit characters', () {
      expect(Validators.validatePhone('123456789'), isNotNull);
      expect(Validators.validatePhone('12345678901234'), isNotNull);
      expect(Validators.validatePhone('012345678a'), isNotNull);
    });
  });

  group('Validators.validateUrl', () {
    test('accepts HTTP and HTTPS URLs', () {
      expect(Validators.validateUrl('http://example.com'), isNull);
      expect(Validators.validateUrl('https://example.com'), isNull);
    });

    test('rejects URLs without the required scheme', () {
      expect(Validators.validateUrl('example.com'), isNotNull);
      expect(Validators.validateUrl('ftp://example.com'), isNotNull);
    });
  });

  group('Validators.validatePassword', () {
    test('accepts a password meeting all requirements', () {
      expect(Validators.validatePassword('Secure#123'), isNull);
    });

    test('rejects passwords missing a requirement', () {
      expect(Validators.validatePassword('Sh0rt!'), isNotNull);
      expect(Validators.validatePassword('lowercase#1'), isNotNull);
      expect(Validators.validatePassword('Uppercase!'), isNotNull);
      expect(Validators.validatePassword('NoSymbol123'), isNotNull);
    });
  });
}
