import 'package:flutter/material.dart';
import 'package:ioatest/core/core_di.dart';
import 'package:ioatest/core/injector/base_injector.dart';
import 'package:ioatest/core/navigation/navigation_service.dart';
import 'package:ioatest/features/company/company_di.dart';
import 'package:ioatest/features/company/presentation/login/bloc/login_bloc.dart';
import 'package:ioatest/routes.dart';

void main() {
  BaseInjector().initialiseAll([CoreDi(), CompanyDi()]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Color(0xffE01E69), 
         inputDecorationTheme: InputDecorationTheme(
           fillColor: lightGrey,
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
          backgroundColor: pink,
          primary: Colors.white,
        )),
      ),
      navigatorKey: BaseInjector().get<NavigationService>().navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: LoginBloc.route,
    );
  }
}

const Color lightGrey = Color(0xffF5F5F5);
 const Color pink = Color(0xffE01E69);