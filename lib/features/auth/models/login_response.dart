class LoginResponse {
  final String accessToken;
  final String refreshToken;
  LoginResponse({required this.accessToken, required this.refreshToken});
  LoginResponse.fromJson(Map<String, dynamic> json)
      : accessToken = json['access_token'],
        refreshToken = json['refresh_token'];
}