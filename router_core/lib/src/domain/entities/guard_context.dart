import 'package:flutter/foundation.dart';

/// Context information provided to route guards during navigation checks.
@immutable
class GuardContext {
  /// The target location (path) of the navigation.
  final String location;

  /// Path parameters extracted from the route.
  final Map<String, String> pathParameters;

  /// Query parameters extracted from the route.
  final Map<String, dynamic> queryParameters;

  /// Extra data passed with the navigation.
  final Object? extra;

  const GuardContext({
    required this.location,
    this.pathParameters = const {},
    this.queryParameters = const {},
    this.extra,
  });

  @override
  String toString() =>
      'GuardContext(location: $location, pathParameters: $pathParameters, queryParameters: $queryParameters)';
}
