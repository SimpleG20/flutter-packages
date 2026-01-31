import 'package:flutter/widgets.dart';
import '../../domain/entities/route_params.dart';
import '../../domain/entities/typed_route.dart';

import 'package:go_router/go_router.dart';

/// Extensions for cleaner navigation syntax.
extension NavigationContextExt on BuildContext {
  /// Navigate to a typed route (replace stack).
  void navigateTo<T extends RouteParams>(AppRoute<T> route, {T? params}) {
    final location = route.buildPath(params);
    GoRouter.of(this).go(location, extra: params);
  }

  /// Push a typed route.
  Future<R?> pushTo<T extends RouteParams, R>(AppRoute<T> route, {T? params}) {
    final location = route.buildPath(params);
    return GoRouter.of(this).push<R>(location, extra: params);
  }

  /// Push replacement typed route.
  void pushReplacementTo<T extends RouteParams>(
    AppRoute<T> route, {
    T? params,
  }) {
    final location = route.buildPath(params);
    GoRouter.of(this).pushReplacement(location, extra: params);
  }
}
