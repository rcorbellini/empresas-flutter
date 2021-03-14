import 'package:flutter/material.dart';
import 'package:ioatest/core/core_di.dart';
import 'package:ioatest/core/injector/base_injector.dart';
import 'package:ioatest/core/navigation/navigation_service.dart';
import 'package:ioatest/features/company/company_di.dart';
import 'package:ioatest/features/company/presentation/login/bloc/login_bloc.dart';
import 'package:ioatest/features/company/presentation/splash/splash_page.dart';
import 'package:ioatest/routes.dart';

void main() {
  runApp(MyApp());
}

Future<void> initApp() async {
  BaseInjector().initialiseAll([CoreDi(), CompanyDi()]);

  //mocking for test splash
  return Future.delayed(Duration(seconds: 3));
}

class MyApp extends StatelessWidget {
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
              focusColor: Color(0xffE01E69),
              accentColor: Color(0xffE01E69),
              inputDecorationTheme: InputDecorationTheme(
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
                backgroundColor: MainTheme.pink,
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

class MainTheme {
  static const Color lightGrey = Color(0xffF5F5F5);
  static const Color pink = Color(0xffE01E69);
}
