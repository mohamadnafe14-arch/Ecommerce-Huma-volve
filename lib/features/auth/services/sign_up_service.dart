import 'dart:developer';

import 'package:ecommerce_app_huma_volve/core/consts/api_service_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/services/api_service.dart';
import 'package:ecommerce_app_huma_volve/features/auth/models/sign_up_input_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/models/sign_up_response.dart';

class SignUpService {
  final ApiService _apiService;
  SignUpService(this._apiService);

  Future<SignUpResponse> signUp({
    required SignUpInputModel signUpInputModel,
  }) async {
    final response = await _apiService.post(
      endpoint: ApiServiceEndpoints.signUp,
      data: signUpInputModel.toJson(),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    final data = response.data;
    log(data.toString());
    return SignUpResponse.fromJson(data);
  }
}
