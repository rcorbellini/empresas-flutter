import 'package:flutter/material.dart';
import 'package:ioatest/core/core_di.dart';
import 'package:ioatest/core/injector/base_injector.dart';
import 'package:ioatest/core/navigation/navigation_service.dart';
import 'package:ioatest/features/company/company_di.dart';
import 'package:ioatest/features/company/presentation/login/bloc/login_bloc.dart';
import 'package:ioatest/features/company/presentation/splash/splash_page.dart';
import 'package:ioatest/routes.dart';

void main() {
  runApp(CompanyApp());
}

///All pre required actions of app are executed here.
///- Initlialized all Injection
Future<void> initApp() async {
  BaseInjector().initialiseAll([CoreDi(), CompanyDi()]);

  //mocking for test splash
  return Future.delayed(const Duration(seconds: 3));
}

///The starter widget of company app
class CompanyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initApp(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(home: Splash());
        } else {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              focusColor: MainTheme.mainColor,
              accentColor: MainTheme.mainColor,
              inputDecorationTheme: const InputDecorationTheme(
                  fillColor: MainTheme.lightGrey,
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 22,
                    horizontal: 26,
                  ),
                  labelStyle: TextStyle(
                    fontSize: 35,
                    decorationColor: Colors.red,
                  )),
              textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                backgroundColor: MainTheme.mainColor,
                primary: Colors.white,
              )),
            ),
            navigatorKey: BaseInjector().get<NavigationService>().navigatorKey,
            onGenerateRoute: generateRoute,
            initialRoute: LoginBloc.route,
          );
        }
      },
    );
  }
}

///Default theme of app
class MainTheme {
  static const Color lightGrey = Color(0xffF5F5F5);
  static const Color mainColor = Color(0xffE01E69);
}
