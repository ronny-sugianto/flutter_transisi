import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_transisi/src/src.dart';

class CreateEmployeeCubit extends Cubit<BaseState> {
  final BaseEmployeeRepository employeeRepository;

  CreateEmployeeCubit({required this.employeeRepository})
      : super(const InitializedState());

  Future<void> createEmployee(Employee employee) async {
    emit(const LoadingState());
    try {
      final created = await employeeRepository.addEmployee(employee);
      emit(SuccessState(data: created, timestamp: DateTime.now()));
    } on ApiException catch (e) {
      emit(ErrorState(
        error: e.toMap()?['error'] ?? 'Failed to create employee',
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
