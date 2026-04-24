import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_transisi/src/src.dart';

class EditEmployeeCubit extends Cubit<BaseState> {
  final BaseEmployeeRepository employeeRepository;

  EditEmployeeCubit({required this.employeeRepository})
      : super(const InitializedState());

  Future<void> editEmployee(String id, Employee employee) async {
    emit(const LoadingState());
    try {
      final updated = await employeeRepository.editEmployeesById(id, employee);
      emit(SuccessState(data: updated, timestamp: DateTime.now()));
    } on ApiException catch (e) {
      emit(ErrorState(
        error: e.toMap()?['error'] ?? 'Failed to update employee',
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
