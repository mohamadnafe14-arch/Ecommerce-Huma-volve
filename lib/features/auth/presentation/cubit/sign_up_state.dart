import '../../domain/entities/auth_user.dart';

sealed class SignUpState {
  const SignUpState();
}

final class SignUpInitial extends SignUpState {
  const SignUpInitial();
}

final class SignUpLoading extends SignUpState {
  const SignUpLoading();
}

final class SignUpSuccess extends SignUpState {
  final AuthUser user;

  const SignUpSuccess(this.user);
}

final class SignUpFailure extends SignUpState {
  final String message;

  const SignUpFailure(this.message);
}
