import 'package:flutter_test/flutter_test.dart';
import 'package:rpl_keamanan/utils/validators.dart';

void main() {
  group('Validators.isValidEmail', () {
    test('accepts a valid email', () {
      expect(Validators.isValidEmail('user@example.com'), isTrue);
    });

    test('rejects an email without @', () {
      expect(Validators.isValidEmail('user.example.com'), isFalse);
    });

    test('rejects an email without a domain', () {
      expect(Validators.isValidEmail('user@'), isFalse);
    });
  });

  group('Validators.sanitize', () {
    test('converts script tags and quotation marks to HTML entities', () {
      expect(
        Validators.sanitize(' <script>alert("x")</script> '),
        '&lt;script&gt;alert(&quot;x&quot;)&lt;/script&gt;',
      );
      expect(Validators.sanitize("'<script>'"), '&#39;&lt;script&gt;&#39;');
    });

    test('trims whitespace at the beginning and end', () {
      expect(Validators.sanitize('  hello  '), 'hello');
    });
  });

  group('Validators.validateText', () {
    test('rejects an empty value', () {
      expect(Validators.validateText(''), isNotNull);
    });

    test('rejects a value longer than maxLength', () {
      expect(Validators.validateText('a' * 101, maxLength: 100), isNotNull);
    });

    test('accepts a valid value', () {
      expect(Validators.validateText('Valid text'), isNull);
    });
  });
}
