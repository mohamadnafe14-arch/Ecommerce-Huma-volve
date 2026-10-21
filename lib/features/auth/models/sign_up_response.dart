class SignUpResponse {
  final int id;
  final String email;
  final String password;
  final String name;
  final String role;
  final String avatar;
  final String createionAt;
  final String updatedAt;
  SignUpResponse({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.role,
    required this.avatar,
    required this.createionAt,
    required this.updatedAt,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      name: json['name'],
      role: json['role'],
      avatar: json['avatar'],
      createionAt: json['creationAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
  
