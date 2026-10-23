import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

class Login {
  final AuthRepository _repository;

  const Login(this._repository);

  Future<AuthSession> call({required String email, required String password}) {
    return _repository.login(email: email, password: password);
  }
}
