import '../../domain/entities/auth_session.dart';

class AuthSessionModel extends AuthSession {
  AuthSessionModel({required super.accessToken, super.refreshToken});
  factory AuthSessionModel.fromJson(Map<String, dynamic> json) {
    return AuthSessionModel(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String?,
    );
  }
}
