class SignUpRequestModel {
  final String name;
  final String email;
  final String password;

  const SignUpRequestModel({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'password': password,
    'avatar': 'https://i.pravatar.cc/300',
  };
}
