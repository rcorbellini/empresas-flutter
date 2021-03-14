import 'package:http/http.dart';
import 'package:ioatest/core/injector/base_injector.dart';
import 'package:ioatest/core/injector/injector_module.dart';
import 'package:ioatest/core/navigation/navigation_service.dart';
import 'package:ioatest/core/utils/client_http.dart';
import 'package:ioatest/core/utils/network_status.dart';

class CoreDi extends InjectorModule {
  @override
  void initialise(BaseInjector injector) {
    injector
      ..register<NetworkStatus, NetworkStatusImp>(
          (injector) => NetworkStatusImp())
      ..register<Client, ClientHttp>((injector) => ClientHttp())
      ..register<NavigationService, NavigationServiceImp>(
          (injector) => NavigationServiceImp());
  }
}
