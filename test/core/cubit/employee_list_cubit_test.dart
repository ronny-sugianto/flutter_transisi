import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_transisi/src/src.dart';

import 'employee_list_cubit_test.mocks.dart';

@GenerateMocks([BaseEmployeeRepository])
void main() {
  late MockBaseEmployeeRepository mockRepo;

  setUp(() {
    mockRepo = MockBaseEmployeeRepository();
  });

  const employee = Employee(
    id: 'emp-1',
    data: EmployeeData(
      firstName: 'Ronny',
      lastName: 'Demo',
      email: 'demo@rons.my.id',
      phone: '089',
      website: 'rons.my.id',
      companyName: 'PT Rons',
    ),
  );

  group('EmployeeListCubit', () {
    test('initial state is InitializedState', () {
      final cubit = EmployeeListCubit(employeeRepository: mockRepo);
      expect(cubit.state, isA<InitializedState>());
    });

    blocTest<EmployeeListCubit, BaseState>(
      'fetchEmployees with non-empty list emits [LoadingState, LoadedState]',
      build: () {
        when(mockRepo.getEmployees()).thenAnswer((_) async => [employee]);
        return EmployeeListCubit(employeeRepository: mockRepo);
      },
      act: (cubit) => cubit.fetchEmployees(),
      expect: () => [isA<LoadingState>(), isA<LoadedState>()],
    );

    blocTest<EmployeeListCubit, BaseState>(
      'LoadedState contains the exact returned employees',
      build: () {
        when(mockRepo.getEmployees()).thenAnswer((_) async => [employee]);
        return EmployeeListCubit(employeeRepository: mockRepo);
      },
      act: (cubit) => cubit.fetchEmployees(),
      verify: (cubit) {
        final state = cubit.state as LoadedState;
        final employees = state.data as List<Employee>;
        expect(employees.length, 1);
        expect(employees.first.id, 'emp-1');
      },
    );

    blocTest<EmployeeListCubit, BaseState>(
      'fetchEmployees with empty list emits [LoadingState, EmptyState]',
      build: () {
        when(mockRepo.getEmployees()).thenAnswer((_) async => []);
        return EmployeeListCubit(employeeRepository: mockRepo);
      },
      act: (cubit) => cubit.fetchEmployees(),
      expect: () => [isA<LoadingState>(), isA<EmptyState>()],
    );

    blocTest<EmployeeListCubit, BaseState>(
      'fetchEmployees on API error emits [LoadingState, ErrorState]',
      build: () {
        when(mockRepo.getEmployees())
            .thenThrow(FetchDataException('Network error'));
        return EmployeeListCubit(employeeRepository: mockRepo);
      },
      act: (cubit) => cubit.fetchEmployees(),
      expect: () => [isA<LoadingState>(), isA<ErrorState>()],
    );

    blocTest<EmployeeListCubit, BaseState>(
      'ErrorState has non-empty error message',
      build: () {
        when(mockRepo.getEmployees())
            .thenThrow(FetchDataException('Network error'));
        return EmployeeListCubit(employeeRepository: mockRepo);
      },
      act: (cubit) => cubit.fetchEmployees(),
      verify: (cubit) {
        expect((cubit.state as ErrorState).error, isNotEmpty);
      },
    );
  });
}
