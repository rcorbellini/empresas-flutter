import 'package:flutter/material.dart';
import 'package:ioatest/features/company/presentation/home/pages/home_theme.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: HomeTheme.gradientBgColor),
        ),
        child: Center(
          child: Image.asset('assets/images/logo_splash.png'),
        ),
      ),
    );
  }
}
