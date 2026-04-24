import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_transisi/src/src.dart';

class DeleteEmployeeCubit extends Cubit<BaseState> {
  final BaseEmployeeRepository employeeRepository;

  DeleteEmployeeCubit({required this.employeeRepository})
      : super(const InitializedState());

  Future<void> deleteEmployee(String id) async {
    emit(const LoadingState());
    try {
      await employeeRepository.deleteEmployeesById(id);
      emit(SuccessState(timestamp: DateTime.now()));
    } on ApiException catch (e) {
      emit(ErrorState(
        error: e.toMap()?['error'] ?? 'Failed to delete employee',
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
