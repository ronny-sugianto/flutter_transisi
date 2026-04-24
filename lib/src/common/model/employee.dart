import 'package:equatable/equatable.dart';
import 'package:flutter_transisi/src/common/model/employee_data.dart';

class Employee extends Equatable {
  final String id;
  final EmployeeData data;

  const Employee({
    required this.id,
    required this.data,
  });

  String get fullName => '${data.firstName} ${data.lastName}'.trim();

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] as String? ?? '',
      data: EmployeeData.fromJson(json['data'] as Map<String, dynamic>? ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'data': data.toJson(),
    };
  }

  Employee copyWith({
    String? id,
    EmployeeData? data,
  }) {
    return Employee(
      id: id ?? this.id,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [id, data];
}
