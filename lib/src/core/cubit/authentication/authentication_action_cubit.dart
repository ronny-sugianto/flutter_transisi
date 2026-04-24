import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_transisi/src/src.dart';

class AuthenticationActionCubit extends Cubit<BaseState> {
  final BaseAuthenticationRepository authRepository;

  AuthenticationActionCubit({required this.authRepository})
      : super(const InitializedState());

  Future<void> login({
    required String username,
    required String password,
  }) async {
    emit(const LoadingState());
    try {
      final user = await authRepository.login(
        username: username,
        password: password,
      );
      emit(AuthenticatedState(data: user, timestamp: DateTime.now()));
    } on ApiException catch (e) {
      emit(
        ErrorState(
          error: e.toMap()?['error'] ?? 'Login failed',
          timestamp: DateTime.now(),
        ),
      );
    } catch (e) {
      emit(ErrorState(error: e.toString(), timestamp: DateTime.now()));
    }
  }

  Future<void> logout() async {
    emit(const LoadingState());
    try {
      await authRepository.logout();
    } catch (e) {
      debugPrint('[$this - logout] - Error while logout: $e');
    }
    emit(const SuccessState());
  }
}
