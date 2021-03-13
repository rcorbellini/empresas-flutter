import 'package:fancy_stream/fancy_stream.dart';
import 'package:ioatest/core/errors/errors.dart';
import 'package:ioatest/core/navigation/navigation_service.dart';
import 'package:ioatest/core/session/session_holder.dart';
import 'package:ioatest/features/company/domain/models/user.dart';
import 'package:ioatest/features/company/domain/use_cases/login_by_user_and_password.dart';
import 'package:ioatest/features/company/presentation/home/bloc/home_bloc.dart';
import 'package:ioatest/features/company/presentation/login/bloc/login_events.dart';
import 'package:ioatest/features/company/presentation/login/bloc/login_status.dart';

class LoginBloc extends FancyDelegate {
  static const String route = '/login';
  final NavigationService navigationService;
  final LoginByUserAndPassword loginByUserAndPassword;

  LoginBloc(
      {required this.navigationService,
      required this.loginByUserAndPassword,
      fancy})
      : super(fancy: fancy) {
    listenOn<LoginEvent>(_onEventDispatched);
  }

  void _onEventDispatched(LoginEvent loginEvent) {
    if (loginEvent is LoginSignEvent) {
      _logar(
          username: map[LoginForm.username], password: map[LoginForm.password]);
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

  void _logar({String? username, String? password}) async {
    if (_validar(username: username, password: password)) {
      print('tentando logar $username e $password');
      final result = await loginByUserAndPassword.call(
          user: username!, password: password!);
      result.fold(_handleErrorLogin, _handleSuccess);
    }
  }

  void _handleErrorLogin(Error e) {
    if (e is UnauthorizedError) {
      //show direct on fields
      dispatchErrorOn<String?>('', key: LoginForm.username);
      dispatchErrorOn<String?>('Usuario Não encontrado',
          key: LoginForm.password);
    } else if (e is NoInternetError) {
      //default message error
      dispatchOn<LoginSatus>(LoginErrorStatus(
          'Não foi possível efetuar a consulta, verifique sua conexão e tente novamente.'));
    } else {
      //default message error
      dispatchOn<LoginSatus>(LoginErrorStatus(
          'Algo inseperado aconteceu, não foi possível e efetuar o login, tente mais tarde'));
    }
  }

  void _handleSuccess(User user) {
    navigationService.navigate(HomeBloc.route, replace: true);
  }
}

enum LoginForm { username, password }
