import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ioatest/core/injector/base_injector.dart';
import 'package:ioatest/core/utils/random_color.dart';
import 'package:ioatest/features/company/domain/models/company.dart';
import 'package:ioatest/features/company/presentation/company/bloc/company_detail_bloc.dart';
import 'package:ioatest/features/company/presentation/company/bloc/company_detail_event.dart';
import 'package:ioatest/features/company/presentation/company/bloc/company_detail_status.dart';
import 'package:ioatest/features/company/presentation/company/pages/company_detail_theme.dart';
import 'package:ioatest/features/company/presentation/shared/loading_ioa_widget.dart';

///Widget Page of detail an Company.
class CompanyDetailPage extends StatefulWidget {
  ///Use [id] to set what company will be loaded;
  const CompanyDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

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
    return Scaffold(
        backgroundColor: Colors.white, body: SafeArea(child: _buildPage()));
  }

  Widget _buildPage() {
    return StreamBuilder<CompanyDetailStatus>(
        stream: bloc.streamOf<CompanyDetailStatus>(),
        builder: (context, snap) {
          if (!snap.hasData) {
            return Container();
          }

          final data = snap.data;

          var title = '';
          if (data is CompanyDetailLoaded) {
            title = data.company.enterpriseName;
          }

          return Column(children: [_buildAppBar(title), _buildDetail(data!)]);
        });
  }

  Widget _buildAppBar(String title) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () =>
                bloc.dispatchOn<CompanyDetailEvent>(CompanyDetailCloseEvent()),
            child: Container(
              height: 40,
              width: 40,
              padding: const EdgeInsets.all(13),
              decoration: const BoxDecoration(
                color: CompanyDetailTheme.bgButtonColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              child: SvgPicture.asset(
                'assets/images/back_arrow.svg',
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.fromLTRB(6, 6, 6, 6),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.rubik(
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetail(CompanyDetailStatus data) {
    if (data is CompanyDetailLoading) {
      return _buildLoading();
    }

    if (data is CompanyDetailLoaded) {
      return _buildCompanyDetail(data.company);
    }

    if (data is CompanyDetailError) {
      return _buildError(data.message);
    }

    return Container();
  }

  Widget _buildLoading() {
    return const Center(child: LoadingIoa());
  }

  Widget _buildError(String message) {
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: GoogleFonts.rubik(
          textStyle: const TextStyle(
              fontSize: 18, color: CompanyDetailTheme.textColorError),
        ),
      ),
    );
  }

  Widget _buildCompanyDetail(Company company) {
    return Expanded(
        child: ListView(
      children: [
        Container(
          height: 120,
          color: RandomColor.random(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: SvgPicture.asset('assets/images/empresa_logo.svg'),
                ),
                Text(
                  company.enterpriseName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rubik(
                    textStyle:
                        const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Text(company.description,
              style: GoogleFonts.rubik(
                textStyle: const TextStyle(fontSize: 18),
              )),
        )
      ],
    ));
  }
}
