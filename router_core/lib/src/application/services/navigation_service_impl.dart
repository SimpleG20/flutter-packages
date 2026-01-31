import 'dart:async';
import 'package:go_router/go_router.dart';

import '../../domain/entities/route_params.dart';
import '../../domain/entities/typed_route.dart';
import '../../domain/interfaces/navigation_service.dart';

/// Concrete implementation of [NavigationService] using [GoRouter].
class NavigationServiceImpl implements NavigationService {
  final GoRouter _router;

  NavigationServiceImpl(this._router);

  @override
  void go<T extends RouteParams>(AppRoute<T> route, {T? params}) {
    final location = route.buildPath(params);
    _router.go(location, extra: params);
  }

  @override
  Future<R?> push<T extends RouteParams, R>(AppRoute<T> route, {T? params}) {
    final location = route.buildPath(params);
    return _router.push<R>(location, extra: params);
  }

  @override
  void pushReplacement<T extends RouteParams>(AppRoute<T> route, {T? params}) {
    final location = route.buildPath(params);
    _router.pushReplacement(location, extra: params);
  }

  @override
  void replace<T extends RouteParams>(AppRoute<T> route, {T? params}) {
    final location = route.buildPath(params);
    _router.replace(location, extra: params);
  }

  @override
  void pop<T extends Object?>([T? result]) {
    if (_router.canPop()) {
      _router.pop(result);
    }
  }

  @override
  bool canPop() => _router.canPop();
}
