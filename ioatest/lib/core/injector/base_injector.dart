import 'package:ioatest/core/injector/get_it_injector.dart';
import 'package:ioatest/core/injector/injector_module.dart';

abstract class BaseInjector {
  factory BaseInjector() {
    //injector used by default.
    return GetItInjector();
  }

  T get<T extends Object>(
      {String key, Map<String, dynamic>? additionalParameters});

  Iterable<T> getAll<T>({Map<String, dynamic>? additionalParameters});

  void unregister<T>({String? key});

  void register<S extends Object, T extends S>(InjectorFactory<S> _factory,
      {bool isSingleton = false, String? key});
}

extension Initilizer on BaseInjector {
  void initialiseAll(Iterable<InjectorModule> modules) {
    modules.forEach((m) => m.initialise(this));
  }
}

typedef T InjectorFactory<T>(BaseInjector injector);
