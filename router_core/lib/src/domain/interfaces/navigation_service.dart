import 'dart:async';
import '../entities/route_params.dart';
import '../entities/typed_route.dart';

/// Abstract service for handling navigation actions testably.
abstract interface class NavigationService {
  /// Navigate to a route, replacing the current stack (GoRouter `go`).
  void go<T extends RouteParams>(AppRoute<T> route, {T? params});

  /// Push a route onto the stack (GoRouter `push`).
  ///
  /// Returns a Future that completes when the pushed route is popped.
  Future<R?> push<T extends RouteParams, R>(AppRoute<T> route, {T? params});

  /// Push a route replacing the current route (GoRouter `pushReplacement`).
  void pushReplacement<T extends RouteParams>(AppRoute<T> route, {T? params});

  /// Replace the current route (GoRouter `replace`).
  void replace<T extends RouteParams>(AppRoute<T> route, {T? params});

  /// Pop the current route.
  void pop<T extends Object?>([T? result]);

  /// Check if it is possible to pop.
  bool canPop();
}
