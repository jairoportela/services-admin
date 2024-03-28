import 'package:services_admin/src/users/data/models/user_role.dart';

class UserModel {
  final String id;
  final UserRole role;
  final String name;

  const UserModel({required this.id, required this.role, required this.name});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      role: getRoleByKey(json['rol']),
      name: json['name'],
    );
  }
}
