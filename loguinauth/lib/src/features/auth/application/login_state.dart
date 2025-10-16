abstract class LoginState {
  final bool isRememberMeChecked;

  const LoginState({this.isRememberMeChecked = false});
}

// Estado Inicial o Listo.
class LoginInitial extends LoginState {
  const LoginInitial({super.isRememberMeChecked});

  LoginInitial copyWith({bool? isRememberMeChecked}) {
    return LoginInitial(
      isRememberMeChecked: isRememberMeChecked ?? this.isRememberMeChecked,
    );
  }
}

// Estado de Carga (mostrando spinner).
class LoginLoading extends LoginState {
  const LoginLoading({super.isRememberMeChecked});
}

// Estado de Éxito (login correcto).
class LoginSuccess extends LoginState {
  const LoginSuccess({super.isRememberMeChecked});
}

// Estado de Error (credenciales incorrectas o error de red).
class LoginFailure extends LoginState {
  final String errorMessage;
  
  const LoginFailure({required this.errorMessage, super.isRememberMeChecked});

  LoginFailure copyWith({String? errorMessage, bool? isRememberMeChecked}) {
    return LoginFailure(
      errorMessage: errorMessage ?? this.errorMessage,
      isRememberMeChecked: isRememberMeChecked ?? this.isRememberMeChecked,
    );
  }
}