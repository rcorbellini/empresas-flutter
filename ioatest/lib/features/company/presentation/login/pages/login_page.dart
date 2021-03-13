import 'package:flutter/material.dart';
import 'package:ioatest/core/injector/base_injector.dart';
import 'package:ioatest/features/company/presentation/login/bloc/login_bloc.dart';
import 'package:ioatest/features/company/presentation/login/bloc/login_events.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc bloc;

  final TextEditingController _userNameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    bloc = BaseInjector().get();
    print(bloc.streamOf<String>().hashCode);
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Container(child: _buildForm())));
  }

  Widget _buildForm() {
    return Column(
      children: [
        StreamBuilder<String?>(
          stream: bloc.streamOf<String?>(key: LoginForm.username),
          builder: (context, snap) {
            _userNameController.value =
                _userNameController.value.copyWith(text: snap.data);

            return TextField(
                decoration: InputDecoration(
                  hintText: 'Username',
                  errorText: snap.error?.toString(),
                ),
                onChanged: (text) =>
                    bloc.dispatchOn<String?>(text, key: LoginForm.username),
                controller: _userNameController);
          },
        ),
        StreamBuilder<String?>(
          stream: bloc.streamOf<String?>(key: LoginForm.password),
          builder: (context, snap) {
            _passwordController.value =
                _passwordController.value.copyWith(text: snap.data);

            return TextField(
                decoration: InputDecoration(
                  hintText: 'Password',
                  errorText: snap.error?.toString(),
                ),
                obscureText: true,
                onChanged: (text) =>
                    bloc.dispatchOn<String?>(text, key: LoginForm.password),
                controller: _passwordController);
          },
        ),
        TextButton(
          onPressed: () => bloc.dispatchOn<LoginEvent>(LoginSignEvent()),
          child: Text('Entrar'),
        ),
      ],
    );
  }
}
