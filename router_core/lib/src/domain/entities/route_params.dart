import 'package:flutter/foundation.dart';

/// Base class for route parameters.
///
/// Extend this class to create typed parameters for your routes.
/// This enables compile-time verification of required navigation data.
///
/// Example:
/// ```dart
/// class UserParams extends RouteParams {
///   final String userId;
///   final String? tab;
///
///   const UserParams({required this.userId, this.tab});
///
///   @override
///   Map<String, String> toPathParams() => {'userId': userId};
///
///   @override
///   Map<String, dynamic> toQueryParams() => tab != null ? {'tab': tab} : {};
/// }
/// ```
@immutable
abstract class RouteParams {
  const RouteParams();

  /// Converts parameters to path parameters (used in the URL path).
  ///
  /// Example: `/user/:userId` → `{'userId': '123'}`
  Map<String, String> toPathParams();

  /// Converts parameters to query parameters (used after `?` in the URL).
  ///
  /// Example: `/user/123?tab=profile` → `{'tab': 'profile'}`
  Map<String, dynamic> toQueryParams() => const {};
}

/// Special class for routes without parameters.
///
/// Use this when your route doesn't require any parameters.
///
/// Example:
/// ```dart
/// class HomeRoute extends TypedRoute<NoParams> {
///   @override String get name => 'home';
///   @override String get path => '/';
///   @override String buildPath([NoParams? params]) => path;
/// }
/// ```
@immutable
class NoParams extends RouteParams {
  const NoParams();

  @override
  Map<String, String> toPathParams() => const {};

  @override
  Map<String, dynamic> toQueryParams() => const {};
}
