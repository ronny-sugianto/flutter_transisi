part of 'base_employee_repository.dart';

class EmployeeRepository extends BaseEmployeeRepository {
  final BaseApiClient apiClient;

  EmployeeRepository({required this.apiClient});

  @override
  Future<List<Employee>> getEmployees() async {
    final response = await apiClient.get(
      UrlConstant.baseUrl + UrlConstant.employee,
      queryParams: UrlConstant.projectId,
      headers: UrlConstant.headers,
    );

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final records = body['data'] as List<dynamic>;

    return records
        .cast<Map<String, dynamic>>()
        .map((record) => Employee.fromJson(record))
        .toList();
  }

  @override
  Future<Employee> getEmployeesById(String id) async {
    final response = await apiClient.get(
      '${UrlConstant.baseUrl}${UrlConstant.employee}/$id',
      queryParams: UrlConstant.projectId,
      headers: UrlConstant.headers,
    );

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final record = body['data'] as Map<String, dynamic>;

    return Employee.fromJson(record);
  }

  @override
  Future<Employee> addEmployee(Employee employee) async {
    final response = await apiClient.post(
      UrlConstant.baseUrl + UrlConstant.employee,
      data: {
        "data": employee.data.toJson(),
      },
      queryParams: UrlConstant.projectId,
      headers: UrlConstant.headers,
    );

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final record = body['data'] as Map<String, dynamic>;

    return Employee.fromJson(record);
  }

  @override
  Future<Employee> editEmployeesById(String id, Employee employee) async {
    final response = await apiClient.put(
      '${UrlConstant.baseUrl}${UrlConstant.employee}/$id',
      data: {
        "data": employee.data.toJson(),
      },
      queryParams: UrlConstant.projectId,
      headers: UrlConstant.headers,
    );

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final record = body['data'] as Map<String, dynamic>;

    return Employee.fromJson(record);
  }

  @override
  Future<void> deleteEmployeesById(String id) async {
    await apiClient.delete(
      '${UrlConstant.baseUrl}${UrlConstant.employee}/$id',
      queryParams: UrlConstant.projectId,
      headers: UrlConstant.headers,
    );
  }
}
