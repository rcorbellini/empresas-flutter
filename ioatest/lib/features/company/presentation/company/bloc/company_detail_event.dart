///default (base) company detail event
abstract class CompanyDetailEvent {}

///Use to request a load of company by [id]
class CompanyDetailLoadByIdEvent extends CompanyDetailEvent {
  /// Request a load by [id]
  CompanyDetailLoadByIdEvent(this.id);

  /// Id of Company
  final int id;
}

///Use to request close screen
class CompanyDetailCloseEvent extends CompanyDetailEvent {}
