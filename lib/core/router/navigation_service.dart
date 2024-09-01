import '../../app/app.dart';

class NavigationService {
  static final _navigator = AppGlobal.navigatorKey.currentState!;

  void pop<T extends Object?>([T? result]) {
    _navigator.pop(result);
  }

  Future<T?> pushNamed<T extends Object?>(
    String name, {
    Object? arguments,
  }) {
    return _navigator.pushNamed<T>(name, arguments: arguments);
  }

  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String name, {
    TO? result,
    Object? arguments,
  }) {
    return _navigator.pushReplacementNamed<T, TO>(
      name,
      result: result,
      arguments: arguments,
    );
  }
}
