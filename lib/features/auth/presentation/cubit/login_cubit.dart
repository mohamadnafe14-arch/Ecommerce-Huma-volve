import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/login.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final Login _login;

  LoginCubit(this._login) : super(const LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(const LoginLoading());
    try {
      final session = await _login(email: email, password: password);
      if (!isClosed) emit(LoginSuccess(session));
    } catch (error) {
      if (!isClosed) emit(LoginFailure(error.toString()));
    }
  }
}
