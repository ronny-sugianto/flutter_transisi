import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_transisi/src/src.dart';
part 'cache_client.dart';

abstract class BaseCacheClient {
  Future get(String key, CacheType type);

  Future<void> save(dynamic data, String key, CacheType type);

  Future<bool> delete(String key);

  Future<bool> reset();
}