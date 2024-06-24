class ServiceLocator {
  static final _locator = ServiceLocator._internal();
  factory ServiceLocator() => _locator;
  ServiceLocator._internal();
  void register<T>(T instance) => _locator._serviceMap[T] = instance;
  T get<T>() => _locator._serviceMap[T] as T;
  final Map<Type, dynamic> _serviceMap = {};
}
