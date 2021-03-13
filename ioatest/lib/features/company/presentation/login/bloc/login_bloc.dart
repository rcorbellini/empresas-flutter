import 'package:fancy_stream/fancy_stream.dart';
import 'package:ioatest/core/navigation/navigation_service.dart';
import 'package:ioatest/features/company/presentation/login/bloc/login_events.dart';

class LoginBloc extends FancyDelegate {
  static const String route = '/login';
  final NavigationService navigationService;

  LoginBloc({required this.navigationService, fancy}) : super(fancy: fancy) {
    listenOn<LoginEvent>(_onEventDispatched);
  }

  void _onEventDispatched(LoginEvent loginEvent) {
    if (loginEvent is LoginSignEvent) {
      _logar(
          username: map[LoginForm.username], password: map[LoginForm.password]);
    }
  }

  void _logar({String? username, String? password}) {
    if (_validar(username: username, password: password)) {
      print('tentando logar $username e $password');
    }
  }

  bool _validar({String? username, String? password}) {
    bool valid = true;
    if (username == null || username.isEmpty) {
      dispatchErrorOn<String?>('É Obrigado informar o Usuario!',
          key: LoginForm.password);
      valid = false;
    }
    if (username == null || username.isEmpty) {
      dispatchErrorOn<String?>('É Obrigado informar a senha!',
          key: LoginForm.password);
      valid = false;
    }

    return valid;
  }

  void _dispatchCredentialNotFound() {
    dispatchErrorOn<String?>('', key: LoginForm.username);
    dispatchErrorOn<String?>('Usuario Não encontrado', key: LoginForm.password);
  }
}

enum LoginForm { username, password }
