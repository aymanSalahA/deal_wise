abstract class LoginState {
  const LoginState();
}
class LoginInitial extends LoginState {
  const LoginInitial() : super();
}
class LoginLoading extends LoginState {
  const LoginLoading() : super();
}

 
class LoginSuccess extends LoginState {
 
  final String email;
  const LoginSuccess(this.email) : super();
}


class LoginFailure extends LoginState {
  final String errorMessage;
  const LoginFailure(this.errorMessage) : super();
}
