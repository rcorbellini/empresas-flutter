import 'package:get_it/get_it.dart';
import 'package:ioatest/core/injector/base_injector.dart';

class GetItInjector implements BaseInjector {
  static final GetItInjector _singleton = GetItInjector._internal();

  factory GetItInjector() {
    return _singleton;
  }

  GetItInjector._internal();

  @override
  T get<T extends Object>(
      {String? key, Map<String, dynamic>? additionalParameters}) {
    return GetIt.instance<T>(instanceName: key);
  }

  @override
  Iterable<T> getAll<T>({Map<String, dynamic>? additionalParameters}) {
    throw UnimplementedError();
  }

  @override
  void register<S extends Object, T extends S>(_factory,
      {bool isSingleton = false, String? key}) {
    if (isSingleton) {
      GetIt.instance.registerSingleton<S>(_factory(this), instanceName: key);
    } else {
      GetIt.instance
          .registerFactory<S>(() => _factory(this), instanceName: key);
    }
  }

  @override
  void unregister<T>({String? key}) {
    throw UnimplementedError();
  }
}
