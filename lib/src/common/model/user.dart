import 'package:equatable/equatable.dart';
import 'package:flutter_transisi/src/common/model/user_data.dart';

class User extends Equatable {
  final String id;
  final UserData data;

  const User({
    required this.id,
    required this.data,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String? ?? '',
      data: UserData.fromJson(json['data'] as Map<String, dynamic>? ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'data': data.toJson(),
    };
  }

  @override
  List<Object?> get props => [id, data];
}
