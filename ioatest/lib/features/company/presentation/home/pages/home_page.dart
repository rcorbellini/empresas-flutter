import 'package:flutter/material.dart';
import 'package:ioatest/core/injector/base_injector.dart';
import 'package:ioatest/core/session/session_holder.dart';
import 'package:ioatest/features/company/domain/models/company.dart';
import 'package:ioatest/features/company/presentation/home/bloc/home_bloc.dart';
import 'package:ioatest/features/company/presentation/home/bloc/home_event.dart';
import 'package:ioatest/features/company/presentation/home/bloc/home_state.dart';
import 'package:ioatest/features/company/presentation/login/bloc/login_bloc.dart';
import 'package:ioatest/features/company/presentation/login/bloc/login_events.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc bloc;

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

  //TODO remover
  void mockSession() {
    SessionHolder().uid = 'testeapple@ioasys.com.br';
    SessionHolder().client = '11SN7w6NBMDiaDxU5K85dA';
    SessionHolder().acessToken = 'xdnv8Q_CqD8SKm0e9xQLOA';
    bloc.dispatchOn<HomeEvent>(HomeDetailEvent(49));
  }

  Widget _buildForm() {
    mockSession();
    return Column(
      children: [
        StreamBuilder<String>(
          stream: bloc.streamOf<String>(key: HomeForm.preamble),
          builder: (context, snap) {
            _userNameController.value =
                _userNameController.value.copyWith(text: snap.data);

            return TextField(
                decoration: InputDecoration(
                  hintText: 'Procura',
                  errorText: snap.error?.toString(),
                ),
                onChanged: (text) =>
                    bloc.dispatchOn<String>(text, key: HomeForm.preamble),
                controller: _userNameController);
          },
        ),
        StreamBuilder<HomeState>(
          stream: bloc.streamOf<HomeState>(),
          builder: (context, snap) {
            if (!snap.hasData) {
              return Text('sem conteudo');
            }
            final data = snap.data;

            if (data is HomeLoading) {
              return Text('Carregando');
            }

            if (data is HomeListLoaded) {
              return Text(data.companies.toString());
            }

            if (data is HomeError) {
              return Text(data.message);
            }

            return Container();
          },
        ),
      ],
    );
  }
}
