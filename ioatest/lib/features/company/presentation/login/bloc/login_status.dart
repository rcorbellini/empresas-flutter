abstract class LoginSatus {}

class LoginLoadingStatus extends LoginSatus {}

class LoginErrorStatus extends LoginSatus {
  final String message;

  LoginErrorStatus(this.message);
}
