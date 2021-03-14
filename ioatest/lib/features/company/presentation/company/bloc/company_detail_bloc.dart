import 'package:fancy_stream/fancy_stream.dart';
import 'package:ioatest/core/errors/errors.dart';
import 'package:ioatest/core/navigation/navigation_service.dart';
import 'package:ioatest/features/company/domain/models/company.dart';
import 'package:ioatest/features/company/domain/use_cases/load_company_by_id.dart';
import 'package:ioatest/features/company/presentation/company/bloc/company_detail_event.dart';
import 'package:ioatest/features/company/presentation/company/bloc/company_detail_status.dart';

///Bloc to handle all interaction of page Detail.
class CompanyDetailBloc extends FancyDelegate {
  ///the constructor
  CompanyDetailBloc(
      {required this.loadCompanyById, required this.navigationService, fancy})
      : super(fancy: fancy) {
    listenOn<CompanyDetailEvent>(_onEventDispatched);
  }

  ///the route of Company Detail
  static const String route = '/company/detail';

  ///Use case of company load by id
  final LoadCompanyById loadCompanyById;

  ///The navigator, to route for some page.
  final NavigationService navigationService;

  void _onEventDispatched(CompanyDetailEvent event) {
    if (event is CompanyDetailLoadByIdEvent) {
      _loadById(event.id);
    } else if (event is CompanyDetailCloseEvent) {
      _pop();
    }
  }

  void _pop() {
    navigationService.pop();
  }

  void _loadById(id) async {
    _dispatchLoading();
    final result = await loadCompanyById.call(filterId: id);
    result.fold(_dispatchError, _dispatchCompany);
  }

  void _dispatchError(Error error) {
    if (error is NoInternetError) {
      dispatchOn<CompanyDetailStatus>(CompanyDetailError(
          'Não foi possível efetuar a consulta, verifique sua conexão'
          ' e tente novamente.'));
    } else if (error is RemoteError) {
      dispatchOn<CompanyDetailStatus>(
          CompanyDetailError('Algo inseperado aconteceu, tente mais tarde.'));
    } else {
      dispatchOn<CompanyDetailStatus>(
          CompanyDetailError('Algo inseperado aconteceu.'));
    }
  }

  void _dispatchCompany(Company company) {
    dispatchOn<CompanyDetailStatus>(CompanyDetailLoaded(company));
  }

  void _dispatchLoading() {
    dispatchOn<CompanyDetailStatus>(CompanyDetailLoading());
  }
}
