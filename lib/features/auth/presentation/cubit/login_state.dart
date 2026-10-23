import '../../domain/entities/auth_session.dart';

sealed class LoginState {
  const LoginState();
}

final class LoginInitial extends LoginState {
  const LoginInitial();
}

final class LoginLoading extends LoginState {
  const LoginLoading();
}

final class LoginSuccess extends LoginState {
  final AuthSession session;

  const LoginSuccess(this.session);
}

final class LoginFailure extends LoginState {
  final String message;

  const LoginFailure(this.message);
}
