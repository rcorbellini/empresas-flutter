


import 'package:fancy_stream/fancy_stream.dart';
import 'package:ioatest/core/errors/errors.dart';
import 'package:ioatest/features/company/domain/models/company.dart';
import 'package:ioatest/features/company/domain/use_cases/load_company_by_name.dart';
import 'package:ioatest/features/company/presentation/home/bloc/home_state.dart';

class HomeBloc extends FancyDelegate{
  LoadCompanyByName loadCompanyByName;


  HomeBloc({required this.loadCompanyByName, fancy}) : super(fancy: fancy){
    listenOn<String>(dispatchSearchByName, key: HomeForm.preamble);
  }

  void dispatchSearchByName(String name) async {
    dispatchLoading();
    final result = await loadCompanyByName.call(filterName: name);
    result.fold(dispatchError, dispatchCompanyList);
  }

  void dispatchError(Error error){
    if(error is NoInternetError){      
      dispatchOn<HomeState>(HomeError("Não foi possível efetuar a consulta, verifique sua conexão e tente novamente."));
    }else if (error is RemoteError){
      dispatchOn<HomeState>(HomeError("Algo inseperado aconteceu, tente mais tarde."));
    }else{
      dispatchOn<HomeState>(HomeError("Algo inseperado aconteceu."));
    }
  }

  void dispatchCompanyList(List<Company> list){
    dispatchOn<HomeState>(HomeListLoaded(list));
  }

   void dispatchLoading(){
    dispatchOn<HomeState>(HomeLoading());
  }
}



enum HomeForm{
  preamble
}