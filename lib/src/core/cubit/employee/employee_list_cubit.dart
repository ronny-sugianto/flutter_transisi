import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_transisi/src/src.dart';

class EmployeeListCubit extends Cubit<BaseState> {
  final BaseEmployeeRepository employeeRepository;

  EmployeeListCubit({required this.employeeRepository})
      : super(const InitializedState());

  Future<void> fetchEmployees() async {
    emit(const LoadingState());
    try {
      final employees = await employeeRepository.getEmployees();
      if (employees.isEmpty) {
        emit(EmptyState(timestamp: DateTime.now()));
      } else {
        emit(LoadedState(data: employees, timestamp: DateTime.now()));
      }
    } on ApiException catch (e) {
      emit(ErrorState(
        error: e.toMap()?['error'] ?? 'Failed to load employees',
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      emit(ErrorState(
        error: e.toString(),
        timestamp: DateTime.now(),
      ));
    }
  }
}
