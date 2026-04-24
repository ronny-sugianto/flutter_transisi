part of 'base_authentication_repository.dart';

class AuthenticationRepository extends BaseAuthenticationRepository {
  final BaseApiClient apiClient;
  final BaseCacheClient cacheClient;

  AuthenticationRepository({
    required this.apiClient,
    required this.cacheClient,
  });

  @override
  Future<User> login({
    required String username,
    required String password,
  }) async {
    final response = await apiClient.get(
      UrlConstant.baseUrl + UrlConstant.login,
      queryParams: UrlConstant.projectId,
      headers: UrlConstant.headers,
    );

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final records = body['data'] as List<dynamic>;

    final matched = records.cast<Map<String, dynamic>>().firstWhere(
          (record) {
            final data = record['data'] as Map<String, dynamic>? ?? {};
            return data['username'] == username && data['password'] == password;
          },
          orElse: () => throw UnauthorizedException('Invalid credentials'),
        );

    final user = User.fromJson(matched);

    await cacheClient.save(
      jsonEncode(user.toJson()),
      CacheKey.userData,
      CacheType.string,
    );

    return user;
  }

  @override
  Future<void> logout() async {
    await cacheClient.delete(CacheKey.userData);
  }

  @override
  Future<bool> isLogged() async =>
      await cacheClient.get(CacheKey.userData, CacheType.string) != null;
}
