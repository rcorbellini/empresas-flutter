import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ioatest/core/injector/base_injector.dart';
import 'package:ioatest/features/company/presentation/login/bloc/login_bloc.dart';
import 'package:ioatest/features/company/presentation/login/bloc/login_events.dart';
import 'package:ioatest/features/company/presentation/login/bloc/login_status.dart';
import 'package:ioatest/features/company/presentation/login/pages/login_text_form_field_widget.dart';
import 'package:ioatest/features/company/presentation/login/pages/login_theme.dart';
import 'package:ioatest/features/company/presentation/shared/loading_ioa_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc bloc;

  final TextEditingController _userController = TextEditingController();

  final TextEditingController _pwdController = TextEditingController();

  @override
  void initState() {
    bloc = BaseInjector().get();
    print(bloc.streamOf<String>().hashCode);
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder<LoginState>(
          stream: bloc.streamOf<LoginState>(),
          builder: (context, snap) {
            final data = snap.data;
            return Column(children: [
              RoundedAppBar(),
              Container(
                child: _buildMainContent(data ?? LoginInitialState()),
              )
            ]);
          },
        ),
      ),
    );
  }

  Widget _loading() {
    return const Center(child: LoadingIoa());
  }

  Widget _buildMainContent(LoginState status) {
    final isLoading = status is LoginLoadingState;
    if (isLoading) {
      return Stack(
        children: [
          _buildForm(status),
          _loading(),
        ],
      );
    }

    return _buildForm(status);
  }

  Widget _buildForm(LoginState status) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildUser(status),
        _buildPassword(status),
        _buildButtonEntrar(),
      ],
    );
  }

  Widget _buildUser(LoginState status) {
    final error = status is LoginErrorState;

    return LoginTextFormField(
      isPassword: false,
      label: 'Email',
      onChanged: dispatchUser,
      withError: error,
      controller: _userController,
    );
  }

  Widget _buildPassword(LoginState status) {
    //ignorado pro smartcast funcionar
    // ignore: omit_local_variable_types
    final bool error = status is LoginErrorState;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        LoginTextFormField(
          isPassword: true,
          label: 'Senha',
          onChanged: dispatchPassword,
          withError: error,
          controller: _pwdController,
        ),
        _buildErrorMessage(error ? status.message : null)
      ],
    );
  }

  Widget _buildErrorMessage(String? message) {
    if (message == null) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Text(
        message, //status.message,
        style: GoogleFonts.rubik(
          textStyle:
              const TextStyle(fontSize: 16, color: LoginTheme.textColorError),
        ),
      ),
    );
  }

  Widget _buildButtonEntrar() {
    return Container(
      height: 48 + 12 + 12,
      padding: const EdgeInsets.fromLTRB(42, 12, 42, 12),
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        onPressed: () => bloc.dispatchOn<LoginEvent>(LoginSignEvent()),
        child: Text(
          'ENTRAR',
          style: GoogleFonts.rubik(
            textStyle: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }

  void dispatchPassword(String text) {
    bloc.dispatchOn<String?>(text, key: LoginForm.password);
  }

  void dispatchUser(String text) {
    bloc.dispatchOn<String?>(text, key: LoginForm.username);
  }
}

class RoundedAppBar extends StatelessWidget {
  ///the heigt of AppBar
  final _height = 300.0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        SizedBox.fromSize(
          size: Size.fromHeight(_height),
          child: LayoutBuilder(builder: (context, constraint) {
            final width = constraint.maxWidth * 4;
            return ClipRect(
              child: OverflowBox(
                maxHeight: double.infinity,
                maxWidth: double.infinity,
                child: SizedBox(
                  width: width,
                  height: width,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: width / 2 - _height / 2),
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            begin: Alignment(0.5, -0.5),
                            end: Alignment(-0.5, 0.5),
                            colors: LoginTheme.gradientBgColor),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        Center(
          child: Column(
            children: [
              Image.asset('assets/images/logo_login.png'),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  'Seja bem vindo ao empresas!',
                  style: GoogleFonts.rubik(
                    textStyle:
                        const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
