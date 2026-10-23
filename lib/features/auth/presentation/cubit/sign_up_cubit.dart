import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/sign_up.dart';
import 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUp _signUp;

  SignUpCubit(this._signUp) : super(const SignUpInitial());

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(const SignUpLoading());
    try {
      final user = await _signUp(name: name, email: email, password: password);
      if (!isClosed) emit(SignUpSuccess(user));
    } catch (error) {
      if (!isClosed) emit(SignUpFailure(error.toString()));
    }
  }
}
