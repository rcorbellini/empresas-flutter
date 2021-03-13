import 'package:ioatest/features/company/domain/models/company.dart';

abstract class HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}

class HomeListLoaded extends HomeState {
  final List<Company> companies;

  HomeListLoaded(this.companies);
}
