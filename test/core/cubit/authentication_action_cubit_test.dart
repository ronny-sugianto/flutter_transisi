import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_transisi/src/src.dart';

import 'authentication_action_cubit_test.mocks.dart';

@GenerateMocks([BaseAuthenticationRepository])
void main() {
  late MockBaseAuthenticationRepository mockRepo;

  setUp(() {
    mockRepo = MockBaseAuthenticationRepository();
  });

  const testUser = User(
    id: 'user-1',
    data: UserData(username: 'demo', password: 'test1234'),
  );

  group('AuthenticationActionCubit', () {
    test('initial state is InitializedState', () {
      final cubit = AuthenticationActionCubit(authRepository: mockRepo);
      expect(cubit.state, isA<InitializedState>());
    });

    blocTest<AuthenticationActionCubit, BaseState>(
      'login success emits [LoadingState, AuthenticatedState]',
      build: () {
        when(mockRepo.login(username: 'demo', password: 'test1234'))
            .thenAnswer((_) async => testUser);
        return AuthenticationActionCubit(authRepository: mockRepo);
      },
      act: (cubit) => cubit.login(username: 'demo', password: 'test1234'),
      expect: () => [
        isA<LoadingState>(),
        isA<AuthenticatedState>(),
      ],
    );

    blocTest<AuthenticationActionCubit, BaseState>(
      'login failure emits [LoadingState, ErrorState]',
      build: () {
        when(mockRepo.login(username: anyNamed('username'), password: anyNamed('password')))
            .thenThrow(UnauthorizedException('Invalid credentials'));
        return AuthenticationActionCubit(authRepository: mockRepo);
      },
      act: (cubit) => cubit.login(username: 'wrong', password: 'wrong'),
      expect: () => [
        isA<LoadingState>(),
        isA<ErrorState>(),
      ],
    );

    blocTest<AuthenticationActionCubit, BaseState>(
      'ErrorState has non-empty error message on failure',
      build: () {
        when(mockRepo.login(username: anyNamed('username'), password: anyNamed('password')))
            .thenThrow(UnauthorizedException('Invalid credentials'));
        return AuthenticationActionCubit(authRepository: mockRepo);
      },
      act: (cubit) => cubit.login(username: 'x', password: 'y'),
      verify: (cubit) {
        expect(cubit.state, isA<ErrorState>());
        expect((cubit.state as ErrorState).error, isNotEmpty);
      },
    );

    blocTest<AuthenticationActionCubit, BaseState>(
      'AuthenticatedState contains the returned user',
      build: () {
        when(mockRepo.login(username: 'demo', password: 'test1234'))
            .thenAnswer((_) async => testUser);
        return AuthenticationActionCubit(authRepository: mockRepo);
      },
      act: (cubit) => cubit.login(username: 'demo', password: 'test1234'),
      verify: (cubit) {
        expect(cubit.state, isA<AuthenticatedState>());
        expect((cubit.state as AuthenticatedState).data, equals(testUser));
      },
    );
  });
}
