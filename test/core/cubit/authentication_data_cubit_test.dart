import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_transisi/src/src.dart';

import 'authentication_data_cubit_test.mocks.dart';

@GenerateMocks([BaseAuthenticationRepository])
void main() {
  late MockBaseAuthenticationRepository mockRepo;

  setUp(() {
    mockRepo = MockBaseAuthenticationRepository();
  });

  group('AuthenticationDataCubit', () {
    test('initial state is UnauthenticatedState', () {
      final cubit = AuthenticationDataCubit(authRepository: mockRepo);
      expect(cubit.state, isA<UnauthenticatedState>());
    });

    blocTest<AuthenticationDataCubit, BaseState>(
      'initialize emits AuthenticatedState when logged in',
      build: () {
        when(mockRepo.isLogged()).thenAnswer((_) async => true);
        return AuthenticationDataCubit(authRepository: mockRepo);
      },
      act: (cubit) => cubit.initialize(),
      expect: () => [isA<AuthenticatedState>()],
    );

    blocTest<AuthenticationDataCubit, BaseState>(
      'initialize emits UnauthenticatedState when not logged in',
      build: () {
        when(mockRepo.isLogged()).thenAnswer((_) async => false);
        return AuthenticationDataCubit(authRepository: mockRepo);
      },
      act: (cubit) => cubit.initialize(),
      expect: () => [isA<UnauthenticatedState>()],
    );

    blocTest<AuthenticationDataCubit, BaseState>(
      'logout emits UnauthenticatedState',
      build: () {
        when(mockRepo.logout()).thenAnswer((_) async => Future<void>.value());
        return AuthenticationDataCubit(authRepository: mockRepo);
      },
      act: (cubit) => cubit.logout(),
      expect: () => [isA<UnauthenticatedState>()],
    );
  });
}
