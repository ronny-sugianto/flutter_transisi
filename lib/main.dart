import 'package:flutter/material.dart';
import 'package:flutter_transisi/src/src.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize Client
  final BaseApiClient apiClient = ApiClient();
  final BaseCacheClient cacheClient = CacheClient.instance;

  /// Initialize Repository
  final BaseAuthenticationRepository authRepository = AuthenticationRepository(
    apiClient: apiClient,
    cacheClient: cacheClient,
  );
  final BaseEmployeeRepository employeeRepository = EmployeeRepository(
    apiClient: apiClient,
  );

  runApp(
    TransisiApp(
      apiClient: apiClient,
      cacheClient: cacheClient,
      authRepository: authRepository,
      employeeRepository: employeeRepository,
    ),
  );
}
