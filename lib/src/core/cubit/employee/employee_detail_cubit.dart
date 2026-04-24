import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_transisi/src/src.dart';

class EmployeeDetailCubit extends Cubit<BaseState> {
  EmployeeDetailCubit() : super(const InitializedState());

  void select(Employee employee) {
    emit(LoadedState(data: employee, timestamp: DateTime.now()));
  }
}
