import 'package:flutter/material.dart';

import 'package:ioatest/core/injector/base_injector.dart';
import 'package:ioatest/features/company/presentation/company/bloc/company_detail_bloc.dart';
import 'package:ioatest/features/company/presentation/company/bloc/company_detail_event.dart';
import 'package:ioatest/features/company/presentation/company/bloc/company_detail_status.dart';

class CompanyDetailPage extends StatefulWidget {
  final int id;

  const CompanyDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);
  @override
  _CompanyDetailPageState createState() => _CompanyDetailPageState();
}

class _CompanyDetailPageState extends State<CompanyDetailPage> {
  late CompanyDetailBloc bloc;

  @override
  void initState() {
    bloc = BaseInjector().get();

    dispatchLoadById(widget.id);

    super.initState();
  }

  void dispatchLoadById(int id) {
    bloc.dispatchOn<CompanyDetailEvent>(CompanyDetailLoadByIdEvent(id));
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Container(child: _buildDetail())));
  }

  Widget _buildDetail() {
    return StreamBuilder<CompanyDetailStatus>(
        stream: bloc.streamOf<CompanyDetailStatus>(),
        builder: (context, snap) {
          if (!snap.hasData) {
            return Text('sem conteudo');
          }
          final data = snap.data;

          if (data is CompanyDetailLoading) {
            return Text('Carregando');
          }

          if (data is CompanyDetailLoaded) {
            return Text(data.toString());
          }

          if (data is CompanyDetailError) {
            return Text(data.message);
          }

          return Container();
        });
  }
}
