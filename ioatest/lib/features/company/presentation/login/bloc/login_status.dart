///Default (base) state of login
abstract class LoginState {}

///Define login are loading
class LoginLoadingState extends LoginState {}

///Define login has error.
class LoginErrorState extends LoginState {
  ///the constructor
  LoginErrorState(this.message);

  /// the message of error
  final String message;
}

///Initial state of login
class LoginInitialState extends LoginState {}
