import 'package:ecommerce_app_huma_volve/core/consts/api_service_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/services/api_service.dart';

import '../models/auth_session_model.dart';
import '../models/auth_user_model.dart';
import '../models/login_request_model.dart';
import '../models/sign_up_request_model.dart';

class AuthRemoteDataSource {
  final ApiService _apiService;

  const AuthRemoteDataSource(this._apiService);

  Future<AuthSessionModel> login(LoginRequestModel request) async {
    final response = await _apiService.post(
      endpoint: ApiServiceEndpoints.login,
      data: request.toJson(),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw const FormatException('Invalid login response.');
    }
    return AuthSessionModel.fromJson(data);
  }

  Future<AuthUserModel> signUp(SignUpRequestModel request) async {
    final response = await _apiService.post(
      endpoint: ApiServiceEndpoints.signUp,
      data: request.toJson(),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw const FormatException('Invalid sign-up response.');
    }
    return AuthUserModel.fromJson(data);
  }
}
