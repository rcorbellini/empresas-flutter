import 'dart:convert';

import 'package:ioatest/features/company/data/entities/company_entity.dart';
import 'package:ioatest/features/company/domain/models/company.dart';

abstract class CompanyDetailStatus {}

class CompanyDetailLoading extends CompanyDetailStatus {}

class CompanyDetailError extends CompanyDetailStatus {
  String message;
  CompanyDetailError(
    this.message,
  );
}

class CompanyDetailLoaded extends CompanyDetailStatus {
  final Company company;
  CompanyDetailLoaded(this.company);
}
