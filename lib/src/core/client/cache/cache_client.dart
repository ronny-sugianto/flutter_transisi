part of 'base_cache_client.dart';

class CacheClient extends BaseCacheClient {
  CacheClient._();

  static final CacheClient _instance = CacheClient._();

  static CacheClient get instance => _instance;

  SharedPreferences? _sharedPreferences;

  Future<SharedPreferences> get _client async {
    if (_sharedPreferences != null) {
      return _sharedPreferences!;
    }

    return _sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Future get(String key, CacheType type) async {
    if (_sharedPreferences == null) await _client;

    try {
      dynamic data;
      switch (type) {
        case CacheType.string:
          data = _sharedPreferences?.getString(key);
        case CacheType.int:
          data = _sharedPreferences?.getInt(key);
        case CacheType.double:
          data = _sharedPreferences?.getDouble(key);
        case CacheType.boolean:
          data = _sharedPreferences?.getBool(key);
      }
      return data;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> save(data, String key, CacheType type) async {
    if (_sharedPreferences == null) await _client;
    try {
      switch (type) {
        case CacheType.string:
          await _sharedPreferences?.setString(key, data);
        case CacheType.int:
          await _sharedPreferences?.setInt(key, data);
        case CacheType.double:
          await _sharedPreferences?.setDouble(key, data);
        case CacheType.boolean:
          await _sharedPreferences?.setBool(key, data);
      }

      return data;
    } catch (_) {
      return;
    }
  }

  @override
  Future<bool> delete(String key) async {
    if (_sharedPreferences == null) await _client;
    try {
      await _sharedPreferences?.remove(key);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> reset() async {
    if (_sharedPreferences == null) await _client;
    try {
      return await _sharedPreferences?.clear() == true;
    } catch (_) {
      return false;
    }
  }
}