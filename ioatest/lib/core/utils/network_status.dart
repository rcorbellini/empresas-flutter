import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkStatus {
  Future<bool> isConnected();
}

class NetworkStatusImp extends NetworkStatus {
  NetworkStatusImp();

  @override
  Future<bool>  isConnected() => InternetConnectionChecker().hasConnection;
}
