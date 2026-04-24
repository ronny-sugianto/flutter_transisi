import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_transisi/src/src.dart';

import 'authentication_repository_test.mocks.dart';

@GenerateMocks([BaseApiClient, BaseCacheClient])
void main() {
  late MockBaseApiClient mockApiClient;
  late MockBaseCacheClient mockCacheClient;
  late AuthenticationRepository repository;

  setUp(() {
    mockApiClient = MockBaseApiClient();
    mockCacheClient = MockBaseCacheClient();
    repository = AuthenticationRepository(
      apiClient: mockApiClient,
      cacheClient: mockCacheClient,
    );
  });

  // Helper to build a fake API response body
  http.Response fakeResponse(Map<String, dynamic> body) {
    return http.Response(jsonEncode(body), 200);
  }

  const testUsername = 'demo';
  const testPassword = 'test1234';

  final loginRecords = {
    'data': [
      {
        'id': 'user-1',
        'data': {'username': testUsername, 'password': testPassword},
      },
      {
        'id': 'user-2',
        'data': {'username': 'other', 'password': 'other123'},
      },
    ],
  };

  group('AuthenticationRepository.login()', () {
    test('returns User with correct username when credentials match', () async {
      when(
        mockApiClient.get(
          any,
          queryParams: anyNamed('queryParams'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => fakeResponse(loginRecords));

      when(
        mockCacheClient.save(any, any, any),
      ).thenAnswer((_) async {});

      final user = await repository.login(
        username: testUsername,
        password: testPassword,
      );

      expect(user.data.username, equals(testUsername));
      expect(user.id, equals('user-1'));
    });

    test('throws UnauthorizedException when credentials do not match',
        () async {
      when(
        mockApiClient.get(
          any,
          queryParams: anyNamed('queryParams'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => fakeResponse(loginRecords));

      expect(
        () => repository.login(username: 'wrong', password: 'wrong'),
        throwsA(isA<UnauthorizedException>()),
      );
    });

    test('propagates ApiException thrown by ApiClient', () async {
      when(
        mockApiClient.get(
          any,
          queryParams: anyNamed('queryParams'),
          headers: anyNamed('headers'),
        ),
      ).thenThrow(FetchDataException('Network error'));

      expect(
        () => repository.login(username: testUsername, password: testPassword),
        throwsA(isA<ApiException>()),
      );
    });

    test('saves user to cache after successful login', () async {
      when(
        mockApiClient.get(
          any,
          queryParams: anyNamed('queryParams'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => fakeResponse(loginRecords));

      when(
        mockCacheClient.save(any, any, any),
      ).thenAnswer((_) async {});

      await repository.login(username: testUsername, password: testPassword);

      verify(mockCacheClient.save(any, CacheKey.userData, CacheType.string))
          .called(1);
    });
  });

  group('AuthenticationRepository.isLogged()', () {
    test('returns true when cache has user data', () async {
      when(mockCacheClient.get(CacheKey.userData, CacheType.string))
          .thenAnswer((_) async => '{"id":"user-1","data":{}}');

      final result = await repository.isLogged();
      expect(result, isTrue);
    });

    test('returns false when cache is empty', () async {
      when(mockCacheClient.get(CacheKey.userData, CacheType.string))
          .thenAnswer((_) async => null);

      final result = await repository.isLogged();
      expect(result, isFalse);
    });
  });

  group('AuthenticationRepository.logout()', () {
    test('deletes user data from cache', () async {
      when(mockCacheClient.delete(CacheKey.userData))
          .thenAnswer((_) async => true);

      await repository.logout();

      verify(mockCacheClient.delete(CacheKey.userData)).called(1);
    });
  });
}
