  
import 'package:flutter/material.dart';
import 'package:ioatest/features/company/presentation/company/bloc/company_detail_bloc.dart';
import 'package:ioatest/features/company/presentation/company/pages/company_detail_page.dart';
import 'package:ioatest/features/company/presentation/home/bloc/home_bloc.dart';
import 'package:ioatest/features/company/presentation/home/pages/home_page.dart';
import 'package:ioatest/features/company/presentation/login/bloc/login_bloc.dart';
import 'package:ioatest/features/company/presentation/login/pages/login_page.dart';


 Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case  HomeBloc.route:
        return MaterialPageRoute(builder: (_) => HomePage());
      case LoginBloc.route:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case CompanyDetailBloc.route:
        return MaterialPageRoute(builder: (_) => CompanyDetailPage(id: settings.arguments as int));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('Rota não encontrada ${settings.name}')),
                ));
    }
  }