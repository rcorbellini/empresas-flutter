import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ioatest/features/company/presentation/home/bloc/home_bloc.dart';
import 'package:ioatest/features/company/presentation/home/pages/home_theme.dart';

class HomeSliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final TextEditingController filter;
  final HomeBloc bloc;
  HomeSliverAppBar(
      {required this.expandedHeight, required this.filter, required this.bloc});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var searchBarOffset = expandedHeight - shrinkOffset - 24;
    bool expanded = shrinkOffset < expandedHeight - kToolbarHeight - 48;
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment(2, -2),
                end: Alignment(-2, 2),
                colors: HomeTheme.gradientBgColor),
          ),
          child: Stack(fit: StackFit.expand, children: [
            Positioned(
                left: 0,
                top: 75,
                child: Image.asset(
                  'assets/images/logo_home-3.png',
                )),
            Positioned(
                right: 20,
                top: 75,
                child: Image.asset(
                  'assets/images/logo_home-2.png',
                )),
            Positioned(
                left: 60,
                child: Image.asset(
                  'assets/images/logo_home-1.png',
                )),
            Positioned(
                top: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/logo_home.png',
                ))
          ]),
        ),
        expanded
            ? Positioned(
                top: searchBarOffset,
                left: 16,
                right: 16,
                child: _buildSearch(context),
              )
            : Positioned(
                bottom: -24,
                left: 16,
                right: 16,
                child: _buildSearch(context),
              ),
      ],
    );
  }

  Widget _buildSearch(BuildContext context) {
    return Card(
      child: CupertinoTextField(
        focusNode: FocusNode(),
        controller: filter,
        keyboardType: TextInputType.text,
        placeholder: 'Pesquise por Empresa',
        placeholderStyle: GoogleFonts.rubik(
            textStyle: TextStyle(
          color: HomeTheme.textColor,
          fontSize: HomeTheme.textSearchSize,
        )),
        onChanged: (text) =>
            bloc.dispatchOn<String>(text, key: HomeForm.preamble),
        prefix: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 0.0, 14),
          child: Icon(
            Icons.search,
            size: HomeTheme.iconSearchSize,
            color: HomeTheme.iconColor,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: HomeTheme.bgSearchColor,
        ),
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight * 1.5;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
