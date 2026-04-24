import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_transisi/src/src.dart';

import 'employee_repository_test.mocks.dart';

@GenerateMocks([BaseApiClient])
void main() {
  late MockBaseApiClient mockApiClient;
  late EmployeeRepository repository;

  setUp(() {
    mockApiClient = MockBaseApiClient();
    repository = EmployeeRepository(apiClient: mockApiClient);
  });

  http.Response fakeResponse(Map<String, dynamic> body) {
    return http.Response(jsonEncode(body), 200);
  }

  const employeeData = EmployeeData(
    firstName: 'Ronny',
    lastName: 'Demo',
    email: 'demo@rons.my.id',
    phone: '089',
    website: 'rons.my.id',
    companyName: 'PT Rons',
  );

  const employee = Employee(id: 'emp-1', data: employeeData);

  final singleRecord = {
    'data': {
      'id': 'emp-1',
      'data': {
        'first_name': 'Ronny',
        'last_name': 'Demo',
        'email': 'demo@rons.my.id',
        'phone': '089',
        'website': 'rons.my.id',
        'company_name': 'PT Rons',
      },
    },
  };

  final listResponse = {
    'data': [
      {
        'id': 'emp-1',
        'data': {
          'first_name': 'Ronny',
          'last_name': 'Demo',
          'email': 'demo@rons.my.id',
          'phone': '089',
          'website': 'rons.my.id',
          'company_name': 'PT Rons',
        },
      },
    ],
  };

  group('EmployeeRepository.getEmployees()', () {
    test('returns List<Employee> with correct data on valid response', () async {
      when(
        mockApiClient.get(
          any,
          queryParams: anyNamed('queryParams'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => fakeResponse(listResponse));

      final result = await repository.getEmployees();

      expect(result, isA<List<Employee>>());
      expect(result.length, 1);
      expect(result.first.id, 'emp-1');
      expect(result.first.data.firstName, 'Ronny');
    });

    test('propagates ApiException when ApiClient throws', () async {
      when(
        mockApiClient.get(
          any,
          queryParams: anyNamed('queryParams'),
          headers: anyNamed('headers'),
        ),
      ).thenThrow(FetchDataException('Network error'));

      expect(
        () => repository.getEmployees(),
        throwsA(isA<ApiException>()),
      );
    });
  });

  group('EmployeeRepository.getEmployeesById()', () {
    test('returns single Employee matching the id', () async {
      when(
        mockApiClient.get(
          any,
          queryParams: anyNamed('queryParams'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => fakeResponse(singleRecord));

      final result = await repository.getEmployeesById('emp-1');

      expect(result.id, 'emp-1');
      expect(result.data.email, 'demo@rons.my.id');
    });
  });

  group('EmployeeRepository.addEmployee()', () {
    test('returns created Employee from API response', () async {
      when(
        mockApiClient.post(
          any,
          data: anyNamed('data'),
          queryParams: anyNamed('queryParams'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => fakeResponse(singleRecord));

      final result = await repository.addEmployee(employee);

      expect(result.id, 'emp-1');
      expect(result.data.firstName, 'Ronny');
    });
  });

  group('EmployeeRepository.editEmployeesById()', () {
    test('returns updated Employee from API response', () async {
      when(
        mockApiClient.put(
          any,
          data: anyNamed('data'),
          queryParams: anyNamed('queryParams'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => fakeResponse(singleRecord));

      final result = await repository.editEmployeesById('emp-1', employee);

      expect(result.id, 'emp-1');
      expect(result.data.lastName, 'Demo');
    });
  });

  group('EmployeeRepository.deleteEmployeesById()', () {
    test('completes without error', () async {
      when(
        mockApiClient.delete(
          any,
          queryParams: anyNamed('queryParams'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => http.Response('', 204));

      expect(
        () => repository.deleteEmployeesById('emp-1'),
        returnsNormally,
      );
    });
  });
}
