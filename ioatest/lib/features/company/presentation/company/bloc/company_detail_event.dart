import 'package:ioatest/features/company/data/entities/company_entity.dart';

abstract class CompanyDetailEvent {}

class CompanyDetailLoadByIdEvent extends CompanyDetailEvent {
  final int id;
  CompanyDetailLoadByIdEvent(this.id);
}

class CompanyDetailCloseEvent extends CompanyDetailEvent{

}