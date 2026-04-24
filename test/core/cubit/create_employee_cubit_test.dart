import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_transisi/src/src.dart';

import 'create_employee_cubit_test.mocks.dart';

@GenerateMocks([BaseEmployeeRepository])
void main() {
  late MockBaseEmployeeRepository mockRepo;

  setUp(() {
    mockRepo = MockBaseEmployeeRepository();
  });

  const input = Employee(
    id: '',
    data: EmployeeData(
      firstName: 'Mobile',
      lastName: 'Demo',
      email: 'mobile@rons.my.id',
      phone: '089',
      website: 'rons.my.id',
      companyName: 'PT Rons',
    ),
  );

  const created = Employee(
    id: 'new-id-1',
    data: EmployeeData(
      firstName: 'Mobile',
      lastName: 'Demo',
      email: 'mobile@rons.my.id',
      phone: '089',
      website: 'rons.my.id',
      companyName: 'PT Rons',
    ),
  );

  group('CreateEmployeeCubit', () {
    test('initial state is InitializedState', () {
      final cubit = CreateEmployeeCubit(employeeRepository: mockRepo);
      expect(cubit.state, isA<InitializedState>());
    });

    blocTest<CreateEmployeeCubit, BaseState>(
      'createEmployee success emits [LoadingState, SuccessState]',
      build: () {
        when(mockRepo.addEmployee(any)).thenAnswer((_) async => created);
        return CreateEmployeeCubit(employeeRepository: mockRepo);
      },
      act: (cubit) => cubit.createEmployee(input),
      expect: () => [isA<LoadingState>(), isA<SuccessState>()],
    );

    blocTest<CreateEmployeeCubit, BaseState>(
      'SuccessState contains the created employee',
      build: () {
        when(mockRepo.addEmployee(any)).thenAnswer((_) async => created);
        return CreateEmployeeCubit(employeeRepository: mockRepo);
      },
      act: (cubit) => cubit.createEmployee(input),
      verify: (cubit) {
        expect((cubit.state as SuccessState).data, equals(created));
      },
    );

    blocTest<CreateEmployeeCubit, BaseState>(
      'createEmployee failure emits [LoadingState, ErrorState]',
      build: () {
        when(mockRepo.addEmployee(any))
            .thenThrow(InternalServerErrorException('Server error'));
        return CreateEmployeeCubit(employeeRepository: mockRepo);
      },
      act: (cubit) => cubit.createEmployee(input),
      expect: () => [isA<LoadingState>(), isA<ErrorState>()],
    );

    blocTest<CreateEmployeeCubit, BaseState>(
      'ErrorState has non-empty error message',
      build: () {
        when(mockRepo.addEmployee(any))
            .thenThrow(BadRequestException('Bad request'));
        return CreateEmployeeCubit(employeeRepository: mockRepo);
      },
      act: (cubit) => cubit.createEmployee(input),
      verify: (cubit) {
        expect((cubit.state as ErrorState).error, isNotEmpty);
      },
    );
  });
}
