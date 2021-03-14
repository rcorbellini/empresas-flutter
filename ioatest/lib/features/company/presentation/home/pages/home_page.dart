import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ioatest/core/injector/base_injector.dart';
import 'package:ioatest/features/company/domain/models/company.dart';
import 'package:ioatest/features/company/presentation/home/bloc/home_bloc.dart';
import 'package:ioatest/features/company/presentation/home/bloc/home_event.dart';
import 'package:ioatest/features/company/presentation/home/bloc/home_state.dart';
import 'package:ioatest/features/company/presentation/home/pages/home_sliver_app_bar_widget.dart';
import 'package:ioatest/features/company/presentation/home/pages/home_theme.dart';
import 'package:ioatest/features/company/presentation/shared/loading_ioa_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc bloc;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    bloc = BaseInjector().get();
    print(bloc.streamOf<String>().hashCode);
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
          return <Widget>[_buildAppBar()];
        },
        body: _buildMainContent(),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverPersistentHeader(
      delegate: HomeSliverAppBar(
          expandedHeight: 188, filter: _searchController, bloc: bloc),
      pinned: true,
    );
  }

  Widget _buildMainContent() {
    return StreamBuilder<HomeState>(
      stream: bloc.streamOf<HomeState>(),
      builder: (context, snap) {
        if (!snap.hasData) {
          return Container();
        }
        final data = snap.data;

        if (data is HomeLoading) {
          return _buildLoading();
        }

        if (data is HomeListLoaded) {
          final companies = data.companies;
          if (companies.isEmpty) {
            return _buildEmptyCompanies();
          }
          return _buildListcompany(companies.asMap());
        }

        if (data is HomeError) {
          return _buildError(data.message);
        }

        return Container();
      },
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: GoogleFonts.rubik(
          textStyle: TextStyle(fontSize: 18, color: HomeTheme.textColorError),
        ),
      ),
    );
  }

  Widget _buildEmptyCompanies() {
    return Center(
      child: Text(
        'Nenhum resultado encontrado',
        style: GoogleFonts.rubik(
          textStyle: TextStyle(fontSize: 18, color: HomeTheme.textColor),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Center(child: LoadingIoa());
  }

  Widget _buildListcompany(Map<int, Company> companies) {
    return ListView(children: <Widget>[
      Container(
        padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
        child: Text(
          '${companies.length} resultados encontrados',
          style: GoogleFonts.rubik(
            textStyle: TextStyle(fontSize: 14, color: HomeTheme.textColor),
          ),
        ),
      ),
      ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: companies.length,
        itemBuilder: (context, index) => _buildItemCompany(companies[index]!),
      )
    ]);
  }

  Widget _buildItemCompany(Company company) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
      child: GestureDetector(
        onTap: () => _openDetail(company.id),
        child: Container(
          height: 120,
          decoration: new BoxDecoration(
            color: Color(
              (Random().nextDouble() * 0xFFFFFF).toInt(),
            ).withAlpha(140),
            borderRadius: new BorderRadius.all(
              const Radius.circular(4),
            ),
          ),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: SvgPicture.asset('assets/images/empresa_logo.svg'),
              ),
              Text(
                company.enterpriseName,
                textAlign: TextAlign.center,
                style: GoogleFonts.rubik(
                  textStyle: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }

  void _openDetail(int id) {
    bloc.dispatchOn<HomeEvent>(HomeDetailEvent(id));
  }
}
