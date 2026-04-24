import 'dart:convert';

import 'package:flutter_transisi/src/src.dart';

part 'authentication_repository.dart';

abstract class BaseAuthenticationRepository {
  Future<bool> isLogged();
  Future<User> login({required String username, required String password});
  Future<void> logout();
}
