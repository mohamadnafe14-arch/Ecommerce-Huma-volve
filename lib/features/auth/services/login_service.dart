import 'dart:developer';

import 'package:ecommerce_app_huma_volve/core/consts/api_service_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/services/api_service.dart';
import 'package:ecommerce_app_huma_volve/features/auth/models/login_input_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/models/login_response.dart';

class LoginService {
  final ApiService _apiService;
  LoginService(this._apiService);

  Future<LoginResponse> login({required LoginInputModel loginInputModel}) async {
    final response = await _apiService.post(
      endpoint: ApiServiceEndpoints.login,
      data: loginInputModel.toJson(),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    final data = response.data;
    log(data.toString());
    return LoginResponse.fromJson(data);
  }
}
