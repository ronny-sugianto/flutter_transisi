import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_transisi/src/src.dart';

void main() {
  group('AppValidator.required', () {
    test('returns error message when value is null', () {
      expect(AppValidator.required(null, 'Name'), isNotNull);
    });

    test('returns error message when value is empty', () {
      expect(AppValidator.required('', 'Name'), isNotNull);
    });

    test('returns error message when value is whitespace only', () {
      expect(AppValidator.required('   ', 'Name'), isNotNull);
    });

    test('returns null when value is valid', () {
      expect(AppValidator.required('John', 'Name'), isNull);
    });

    test('error message contains field name', () {
      final result = AppValidator.required(null, 'Phone');
      expect(result, contains('Phone'));
    });
  });

  group('AppValidator.email', () {
    test('returns error when null', () {
      expect(AppValidator.email(null), isNotNull);
    });

    test('returns error when empty', () {
      expect(AppValidator.email(''), isNotNull);
    });

    test('returns error when no @ symbol', () {
      expect(AppValidator.email('notanemail'), isNotNull);
    });

    test('returns error when no domain', () {
      expect(AppValidator.email('user@'), isNotNull);
    });

    test('returns error when no TLD', () {
      expect(AppValidator.email('user@domain'), isNotNull);
    });

    test('returns null for valid email', () {
      expect(AppValidator.email('user@example.com'), isNull);
    });

    test('returns null for valid email with subdomain', () {
      expect(AppValidator.email('user@mail.example.co.id'), isNull);
    });
  });

  group('AppValidator.password', () {
    test('returns error when null', () {
      expect(AppValidator.password(null), isNotNull);
    });

    test('returns error when empty', () {
      expect(AppValidator.password(''), isNotNull);
    });

    test('returns null for any non-empty password', () {
      expect(AppValidator.password('abc'), isNull);
    });
  });
}
