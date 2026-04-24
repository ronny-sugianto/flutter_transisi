import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_transisi/src/src.dart';

class AuthenticationDataCubit extends Cubit<BaseState> {
  final BaseAuthenticationRepository authRepository;

  AuthenticationDataCubit({required this.authRepository})
      : super(const UnauthenticatedState());

  Future<void> initialize() async {
    final logged = await authRepository.isLogged();
    if (logged) {
      emit(AuthenticatedState(timestamp: DateTime.now()));
    } else {
      emit(UnauthenticatedState(timestamp: DateTime.now()));
    }
  }

  Future<void> logout() async {
    await authRepository.logout();
    emit(UnauthenticatedState(timestamp: DateTime.now()));
  }
}
