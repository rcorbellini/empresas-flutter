import 'package:flutter/material.dart';
import 'package:ioatest/features/company/presentation/home/pages/home_theme.dart';

///The splash screen of (flutter) app
class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
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
