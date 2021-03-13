import 'package:ioatest/core/injector/base_injector.dart';
import 'package:ioatest/core/injector/injector_module.dart';
import 'package:ioatest/features/company/data/data_source/company_cache_data_source.dart';
import 'package:ioatest/features/company/data/data_source/company_remote_data_source.dart';
import 'package:ioatest/features/company/data/repositories/company_repository_imp.dart';
import 'package:ioatest/features/company/domain/repositories/company_repository.dart';
import 'package:ioatest/features/company/domain/use_cases/load_company_by_name.dart';
import 'package:ioatest/features/company/presentation/home/bloc/home_bloc.dart';
import 'package:ioatest/features/company/presentation/login/bloc/login_bloc.dart';

class CompanyDi implements InjectorModule {
  @override
  void initialise(BaseInjector injector) {


    injector.register((injector) => LoginBloc());


    injector.register<CompanyRemoteDataSource, CompanyRemoteDataSourceImp>((injector) => CompanyRemoteDataSourceImp(clientHttp: injector.get()));
    injector.register<CompanyCacheDataSource, CompanyCacheDataSourceImp>((injector) => CompanyCacheDataSourceImp());
    injector.register<CompanyRepository,CompanyRepositoryImp>((injector) => CompanyRepositoryImp(cache: injector.get(), remote: injector.get(), networkStatus: injector.get()));
    injector.register<LoadCompanyByName, LoadCompanyByNameImp>((injector) => LoadCompanyByNameImp(companyRepository: injector.get()));
    injector.register((injector) => HomeBloc(loadCompanyByName: injector.get()));
  }
}
