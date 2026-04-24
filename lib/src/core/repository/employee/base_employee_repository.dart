import 'dart:convert';

import 'package:flutter_transisi/src/src.dart';

part 'employee_repository.dart';

abstract class BaseEmployeeRepository {
  Future<List<Employee>> getEmployees();
  Future<Employee> getEmployeesById(String id);
  Future<Employee> addEmployee(Employee employee);
  Future<Employee> editEmployeesById(String id, Employee employee);
  Future<void> deleteEmployeesById(String id);
}
