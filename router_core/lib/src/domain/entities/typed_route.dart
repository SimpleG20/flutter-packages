import 'package:flutter/foundation.dart';

import 'route_params.dart';

/// Base abstract class for defining typed application routes.
///
/// Extend this class to create type-safe route definitions that eliminate
/// magic strings and provide compile-time verification of route parameters.
///
/// Note: Named `AppRoute` to avoid conflict with go_router's `TypedRoute`.
///
/// Example:
/// ```dart
/// class DashboardRoute extends AppRoute<NoParams> {
///   const DashboardRoute();
///
///   @override
///   String get name => 'dashboard';
///
///   @override
///   String get path => '/dashboard';
///
///   @override
///   String buildPath([NoParams? params]) => path;
/// }
///
/// class UserRoute extends AppRoute<UserParams> {
///   const UserRoute();
///
///   @override
///   String get name => 'user';
///
///   @override
///   String get path => '/user/:userId';
///
///   @override
///   String buildPath([UserParams? params]) {
///     if (params == null) return path;
///     var result = '/user/${params.userId}';
///     final query = params.toQueryParams();
///     if (query.isNotEmpty) {
///       result += '?${query.entries.map((e) => '${e.key}=${e.value}').join('&')}';
///     }
///     return result;
///   }
///
///   @override
///   UserParams? extractParams(Map<String, String> pathParams) {
///     final userId = pathParams['userId'];
///     if (userId == null) return null;
///     return UserParams(userId: userId);
///   }
/// }
/// ```
@immutable
abstract class AppRoute<T extends RouteParams> {
  const AppRoute();

  /// Unique name for the route, used with `goNamed`.
  ///
  /// Should be a short, descriptive identifier like 'home', 'user', 'settings'.
  String get name;

  /// Path pattern with placeholders for path parameters.
  ///
  /// Examples:
  /// - `/` for home
  /// - `/user/:userId` for user profile
  /// - `/products/:categoryId/:productId` for nested params
  String get path;

  /// Builds the final path by substituting parameter placeholders.
  ///
  /// If [params] is null, returns the raw [path] pattern.
  /// Otherwise, replaces placeholders with actual values and appends query params.
  String buildPath([T? params]);

  /// Extracts typed parameters from a path parameters map.
  ///
  /// Useful for reconstructing the params object from GoRouterState.
  /// Returns null if required parameters are missing.
  T? extractParams(Map<String, String> pathParams) => null;

  /// Whether this route requires authentication.
  ///
  /// Override to return true for protected routes.
  /// Used by route guards to determine access control.
  bool get requiresAuth => false;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppRoute &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => 'AppRoute(name: $name, path: $path)';
}

/// Marker mixin for organizing application routes.
///
/// Use as a marker on abstract classes that contain typed route instances
/// to provide a centralized, discoverable route registry.
///
/// Example:
/// ```dart
/// abstract class AppRoutes with RouteRegistry {
///   static const home = HomeRoute();
///   static const dashboard = DashboardRoute();
///   static const user = UserRoute();
///   static const settings = SettingsRoute();
/// }
///
/// // Usage:
/// context.navigateTo(AppRoutes.dashboard);
/// context.navigateTo(AppRoutes.user, params: UserParams(userId: '123'));
/// ```
mixin RouteRegistry {}

/// Mixin to add metadata to typed routes.
///
/// Use to attach display information like titles, icons, and
/// visibility flags for navigation drawers and bottom bars.
///
/// Example:
/// ```dart
/// class SettingsRoute extends AppRoute<NoParams> with RouteMetadata<NoParams> {
///   const SettingsRoute();
///
///   @override String get name => 'settings';
///   @override String get path => '/settings';
///   @override String buildPath([NoParams? p]) => path;
///
///   @override String? get title => 'Settings';
///   @override IconData? get icon => Icons.settings;
///   @override bool get showInNavigation => true;
/// }
/// ```
mixin RouteMetadata<T extends RouteParams> on AppRoute<T> {
  /// User-friendly title for display in UI.
  String? get title => null;

  /// Icon for navigation menus.
  ///
  /// Can be IconData, String (asset path), or any type your UI expects.
  dynamic get icon => null;

  /// Whether to show this route in navigation menus.
  bool get showInNavigation => true;

  /// Order index for sorting in navigation menus.
  ///
  /// Lower values appear first. Defaults to max int for unsorted.
  int get navigationOrder => 999;
}
