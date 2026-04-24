import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_transisi/src/src.dart';

import 'delete_employee_cubit_test.mocks.dart';

@GenerateMocks([BaseEmployeeRepository])
void main() {
  late MockBaseEmployeeRepository mockRepo;

  setUp(() {
    mockRepo = MockBaseEmployeeRepository();
  });

  group('DeleteEmployeeCubit', () {
    test('initial state is InitializedState', () {
      final cubit = DeleteEmployeeCubit(employeeRepository: mockRepo);
      expect(cubit.state, isA<InitializedState>());
    });

    blocTest<DeleteEmployeeCubit, BaseState>(
      'deleteEmployee success emits [LoadingState, SuccessState]',
      build: () {
        when(mockRepo.deleteEmployeesById('emp-1'))
            .thenAnswer((_) async => Future<void>.value());
        return DeleteEmployeeCubit(employeeRepository: mockRepo);
      },
      act: (cubit) => cubit.deleteEmployee('emp-1'),
      expect: () => [isA<LoadingState>(), isA<SuccessState>()],
    );

    blocTest<DeleteEmployeeCubit, BaseState>(
      'deleteEmployee failure emits [LoadingState, ErrorState]',
      build: () {
        when(mockRepo.deleteEmployeesById(any))
            .thenThrow(NotFoundException('Not found'));
        return DeleteEmployeeCubit(employeeRepository: mockRepo);
      },
      act: (cubit) => cubit.deleteEmployee('bad-id'),
      expect: () => [isA<LoadingState>(), isA<ErrorState>()],
    );
  });
}
