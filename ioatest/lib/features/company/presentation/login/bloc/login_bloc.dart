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

  void _logar({String? username, String? password}) async {

    _dispatchLoading();
    final result =
        await loginByUserAndPassword.call(user: username??'', password: password??'');
    result.fold(_handleErrorLogin, _handleSuccess);
  }

  void _handleErrorLogin(Error e) {
    if (e is UnauthorizedError) {
      //show direct on fields
      dispatchOn<LoginSatus>(LoginErrorStatus('Credenciais incorretas'));
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
  

  void _dispatchLoading() {
    dispatchOn<LoginSatus>(LoginLoadingStatus());
  }
}

enum LoginForm { username, password }
