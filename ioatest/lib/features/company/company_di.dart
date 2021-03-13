import 'package:ioatest/core/injector/base_injector.dart';
import 'package:ioatest/core/injector/injector_module.dart';
import 'package:ioatest/features/company/presentation/login/bloc/login_bloc.dart';

class CompanyDi implements InjectorModule {
  @override
  void initialise(BaseInjector injector) {
    injector.register((injector) => LoginBloc());
  }
}
