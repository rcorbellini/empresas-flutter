import 'package:ioatest/core/injector/base_injector.dart';
import 'package:ioatest/core/injector/injector_module.dart';
import 'package:ioatest/features/company/data/data_source/company_cache_data_source.dart';
import 'package:ioatest/features/company/data/data_source/company_remote_data_source.dart';
import 'package:ioatest/features/company/data/data_source/user_remote_data_source.dart';
import 'package:ioatest/features/company/data/repositories/company_repository_imp.dart';
import 'package:ioatest/features/company/data/repositories/user_repository_imp.dart';
import 'package:ioatest/features/company/domain/repositories/company_repository.dart';
import 'package:ioatest/features/company/domain/repositories/user_repository.dart';
import 'package:ioatest/features/company/domain/use_cases/load_company_by_id.dart';
import 'package:ioatest/features/company/domain/use_cases/load_company_by_name.dart';
import 'package:ioatest/features/company/domain/use_cases/login_by_user_and_password.dart';
import 'package:ioatest/features/company/presentation/company/bloc/company_detail_bloc.dart';
import 'package:ioatest/features/company/presentation/home/bloc/home_bloc.dart';
import 'package:ioatest/features/company/presentation/login/bloc/login_bloc.dart';

class CompanyDi implements InjectorModule {
  @override
  void initialise(BaseInjector injector) {
    //--->data
    injector
      ..register<CompanyRemoteDataSource, CompanyRemoteDataSourceImp>(
        (injector) => CompanyRemoteDataSourceImp(
          clientHttp: injector.get(),
        ),
      )
      ..register<CompanyCacheDataSource, CompanyCacheDataSourceImp>(
          (injector) => CompanyCacheDataSourceImp(),
          isSingleton: true)
      ..register<CompanyRepository, CompanyRepositoryImp>(
        (injector) => CompanyRepositoryImp(
          cache: injector.get(),
          remote: injector.get(),
          networkStatus: injector.get(),
        ),
      )
      ..register<UserRemoteDataSource, UserRemoteDataSourceImp>(
        (injector) => UserRemoteDataSourceImp(
          clientHttp: injector.get(),
        ),
      )
      ..register<UserRepository, UserRepositoryImp>(
        (injector) => UserRepositoryImp(
          remote: injector.get(),
          networkStatus: injector.get(),
        ),
      )

      //--->domain
      ..register<LoadCompanyByName, LoadCompanyByNameImp>(
        (injector) => LoadCompanyByNameImp(
          companyRepository: injector.get(),
        ),
      )
      ..register<LoadCompanyById, LoadCompanyByIdImp>(
        (injector) => LoadCompanyByIdImp(
          companyRepository: injector.get(),
        ),
      )
      ..register<LoginByUserAndPassword, LoginByUserAndPasswordImp>(
        (i) => LoginByUserAndPasswordImp(
          userRepository: i.get(),
        ),
      )

      //--->presentation
      ..register(
        (injector) => HomeBloc(
          loadCompanyByName: injector.get(),
          navigationService: injector.get(),
        ),
      )
      ..register(
        (injector) => CompanyDetailBloc(
          loadCompanyById: injector.get(),
          navigationService: injector.get(),
        ),
      )
      ..register(
        (injector) => LoginBloc(
          navigationService: injector.get(),
          loginByUserAndPassword: injector.get(),
        ),
      );
  }
}
