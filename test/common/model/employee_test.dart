import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_transisi/src/src.dart';

void main() {
  group('EmployeeData', () {
    const json = {
      'first_name': 'Ronny',
      'last_name': 'Demo',
      'email': 'demo@rons.my.id',
      'phone': '08999999999',
      'website': 'rons.my.id',
      'company_name': 'PT Rons Sinergy',
    };

    const model = EmployeeData(
      firstName: 'Ronny',
      lastName: 'Demo',
      email: 'demo@rons.my.id',
      phone: '08999999999',
      website: 'rons.my.id',
      companyName: 'PT Rons Sinergy',
    );

    test('fromJson parses all fields correctly', () {
      expect(EmployeeData.fromJson(json), equals(model));
    });

    test('toJson produces correct snake_case keys', () {
      expect(model.toJson(), equals(json));
    });

    test('round-trip: fromJson(toJson(x)) == x', () {
      expect(EmployeeData.fromJson(model.toJson()), equals(model));
    });

    test('fromJson handles missing fields with empty string defaults', () {
      final result = EmployeeData.fromJson({});
      expect(result.firstName, '');
      expect(result.email, '');
    });
  });

  group('Employee', () {
    const employeeData = EmployeeData(
      firstName: 'Ronny',
      lastName: 'Demo',
      email: 'demo@rons.my.id',
      phone: '08999999999',
      website: 'rons.my.id',
      companyName: 'PT Rons Sinergy',
    );

    const employee = Employee(id: 'abc-123', data: employeeData);

    final json = {
      'id': 'abc-123',
      'data': {
        'first_name': 'Ronny',
        'last_name': 'Demo',
        'email': 'demo@rons.my.id',
        'phone': '08999999999',
        'website': 'rons.my.id',
        'company_name': 'PT Rons Sinergy',
      },
    };

    test('fromJson parses id and nested data correctly', () {
      expect(Employee.fromJson(json), equals(employee));
    });

    test('toJson produces correct structure', () {
      expect(employee.toJson(), equals(json));
    });

    test('round-trip: fromJson(toJson(e)) == e', () {
      expect(Employee.fromJson(employee.toJson()), equals(employee));
    });

    test('fullName concatenates first and last name', () {
      expect(employee.fullName, 'Ronny Demo');
    });

    test('fromJson handles missing data field', () {
      final result = Employee.fromJson({'id': 'x'});
      expect(result.id, 'x');
      expect(result.data.firstName, '');
    });
  });
}
