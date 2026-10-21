class SignUpInputModel {
  final String email;
  final String password;
  final String name;
  SignUpInputModel({
    required this.email,
    required this.password,
    required this.name,
  });
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
      "avatar": "https://i.pravatar.cc/300",
    };
  }
}
