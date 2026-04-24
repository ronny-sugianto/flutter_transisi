import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_transisi/src/src.dart';

void main() {
  group('UserData', () {
    const json = {'username': 'demo', 'password': 'test1234'};
    const model = UserData(username: 'demo', password: 'test1234');

    test('fromJson parses correctly', () {
      expect(UserData.fromJson(json), equals(model));
    });

    test('toJson produces correct map', () {
      expect(model.toJson(), equals(json));
    });

    test('round-trip: fromJson(toJson(u)) == u', () {
      expect(UserData.fromJson(model.toJson()), equals(model));
    });
  });

  group('User', () {
    const userData = UserData(username: 'demo', password: 'test1234');
    const user = User(id: 'user-id-1', data: userData);

    final json = {
      'id': 'user-id-1',
      'data': {'username': 'demo', 'password': 'test1234'},
    };

    test('fromJson parses id and nested data correctly', () {
      expect(User.fromJson(json), equals(user));
    });

    test('toJson produces correct structure', () {
      expect(user.toJson(), equals(json));
    });

    test('round-trip: fromJson(toJson(u)) == u', () {
      expect(User.fromJson(user.toJson()), equals(user));
    });
  });
}
