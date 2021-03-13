import 'package:flutter/material.dart';
import 'package:ioatest/core/core_di.dart';
import 'package:ioatest/core/injector/base_injector.dart';
import 'package:ioatest/features/company/company_di.dart';
import 'package:ioatest/features/company/presentation/home/pages/home_page.dart';
import 'package:ioatest/features/company/presentation/login/pages/login_page.dart';

void main() {
  BaseInjector().initialiseAll([CoreDi(),CompanyDi()]);
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
      ),
      home: HomePage(),
    );
  }
}
