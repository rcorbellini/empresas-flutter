import 'package:ioatest/features/company/domain/models/company.dart';

///default (base) status of Company detail.
abstract class CompanyDetailStatus {}

///status of loading
class CompanyDetailLoading extends CompanyDetailStatus {}

///Default error of company detail
class CompanyDetailError extends CompanyDetailStatus {
  ///A default error of Company Detail, use [message] to describe.
  CompanyDetailError(
    this.message,
  );

  ///Message of error
  final String message;
}

///Status launched when a company are loaded on detail
class CompanyDetailLoaded extends CompanyDetailStatus {
  ///Use [company] to set what company was load.
  CompanyDetailLoaded(this.company);

  ///The copany loaded.
  final Company company;
}
