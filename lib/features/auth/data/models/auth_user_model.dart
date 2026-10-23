import '../../domain/entities/auth_user.dart';

class AuthUserModel extends AuthUser {
  AuthUserModel({
    required super.id,
    required super.email,
    required super.name,
  });

  

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      id: json['id'] as int,
      email: json['email'] as String,
      name: json['name'] as String,
    );
  }

}
