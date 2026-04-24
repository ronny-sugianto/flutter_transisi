import 'package:equatable/equatable.dart';

class EmployeeData extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String website;
  final String companyName;

  const EmployeeData({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.website,
    required this.companyName,
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) {
    return EmployeeData(
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      website: json['website'] as String? ?? '',
      companyName: json['company_name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'website': website,
      'company_name': companyName,
    };
  }

  EmployeeData copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? website,
    String? companyName,
  }) {
    return EmployeeData(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      website: website ?? this.website,
      companyName: companyName ?? this.companyName,
    );
  }

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        phone,
        website,
        companyName,
      ];
}
