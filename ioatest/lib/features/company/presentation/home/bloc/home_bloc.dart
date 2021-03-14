import 'package:fancy_stream/fancy_stream.dart';
import 'package:ioatest/core/errors/errors.dart';
import 'package:ioatest/core/navigation/navigation_service.dart';
import 'package:ioatest/features/company/domain/models/company.dart';
import 'package:ioatest/features/company/domain/use_cases/load_company_by_name.dart';
import 'package:ioatest/features/company/presentation/company/bloc/company_detail_bloc.dart';
import 'package:ioatest/features/company/presentation/home/bloc/home_event.dart';
import 'package:ioatest/features/company/presentation/home/bloc/home_state.dart';

class HomeBloc extends FancyDelegate {
  static const String route = '/';

  final LoadCompanyByName loadCompanyByName;
  final NavigationService navigationService;

  HomeBloc(
      {required this.loadCompanyByName, required this.navigationService, fancy})
      : super(fancy: fancy) {
    listenOn<String>(_dispatchSearchByName, key: HomeForm.preamble);
    listenOn<HomeEvent>(_onEventDispatched);
  }

  void _onEventDispatched(HomeEvent event) {
    if (event is HomeDetailEvent) {
      navigationService.navigate(CompanyDetailBloc.route, parameter: event.id);
    }
  }

  void _dispatchSearchByName(String name) async {
    _dispatchLoading();
    final result = await loadCompanyByName.call(filterName: name);
    result.fold(_dispatchError, _dispatchCompanyList);
  }

  void _dispatchError(Error error) {
    if (error is NoInternetError) {
      dispatchOn<HomeState>(
          HomeError('Não foi possível efetuar a consulta, verifique sua '
              'conexão e tente novamente.'));
    } else if (error is RemoteError) {
      dispatchOn<HomeState>(
          HomeError('Algo inseperado aconteceu, tente mais tarde.'));
    } else {
      dispatchOn<HomeState>(HomeError('Algo inseperado aconteceu.'));
    }
  }

  void _dispatchCompanyList(List<Company> list) {
    dispatchOn<HomeState>(HomeListLoaded(list));
  }

  void _dispatchLoading() {
    dispatchOn<HomeState>(HomeLoading());
  }
}

enum HomeForm { preamble }
