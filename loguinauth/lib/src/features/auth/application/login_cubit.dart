import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_state.dart'; 

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginInitial());

  void toggleRememberMe(bool newValue) {
    if (state is LoginInitial) {
      emit((state as LoginInitial).copyWith(isRememberMeChecked: newValue));
    } else if (state is LoginFailure) {
      emit((state as LoginFailure).copyWith(isRememberMeChecked: newValue));
    } else {
      emit(LoginInitial(isRememberMeChecked: newValue));
    }
  }

  Future<void> login(String email, String password) async {
    emit(LoginLoading(isRememberMeChecked: state.isRememberMeChecked));
    
    try {
      await Future.delayed(const Duration(seconds: 2));

      // Credenciales de prueba: emanzanilla@gmail.com / 123456
      if (email == 'emanzanilla@gmail.com' && password == '123456') {
        emit(LoginSuccess(isRememberMeChecked: state.isRememberMeChecked));
      } else {
        emit(LoginFailure(
          errorMessage: 'Credenciales inválidas. Usa emanzanilla@gmail.com / 123456.',
          isRememberMeChecked: state.isRememberMeChecked,
        ));
      }

    } catch (e) {
       emit(LoginFailure(
        errorMessage: 'Ocurrió un error inesperado. Verifica tu conexión.',
        isRememberMeChecked: state.isRememberMeChecked,
      ));
    }
  }
}