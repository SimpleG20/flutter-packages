import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/route_params.dart';
import '../../domain/entities/typed_route.dart';

/// Function type for building page widgets from typed route data.
///
/// Provides access to:
/// - [context]: The BuildContext for the route
/// - [state]: The GoRouterState with raw route information
/// - [params]: The extracted typed parameters (null if extraction failed)
typedef AppPageBuilder<T extends RouteParams> =
    Widget Function(BuildContext context, GoRouterState state, T? params);

/// Configuration wrapper for converting typed routes to GoRouter routes.
///
/// Encapsulates an [AppRoute] with its page builder and optional children.
///
/// Example:
/// ```dart
/// final userRouteConfig = AppRouteConfig(
///   route: const UserRoute(),
///   builder: (context, state, params) {
///     return UserPage(userId: params?.userId ?? '');
///   },
///   children: [
///     const UserProfileRoute().toGoRoute(
///       builder: (ctx, state, params) => UserProfilePage(),
///     ),
///   ],
/// );
///
/// // Then use:
/// final goRoute = userRouteConfig.toGoRoute();
/// ```
class AppRouteConfig<T extends RouteParams> {
  /// The typed route definition.
  final AppRoute<T> route;

  /// Builder function for the page widget.
  final AppPageBuilder<T> builder;

  /// Nested child routes.
  final List<RouteBase> children;

  /// Optional redirect function for this specific route.
  final String? Function(BuildContext, GoRouterState)? redirect;

  const AppRouteConfig({
    required this.route,
    required this.builder,
    this.children = const [],
    this.redirect,
  });

  /// Converts this configuration to a [GoRoute].
  ///
  /// Automatically:
  /// - Uses the route's name and path
  /// - Extracts typed parameters from GoRouterState
  /// - Passes them to the builder function
  GoRoute toGoRoute() {
    return GoRoute(
      name: route.name,
      path: route.path,
      redirect: redirect,
      routes: children,
      builder: (context, state) {
        final params = route.extractParams(state.pathParameters);
        return builder(context, state, params);
      },
    );
  }
}

/// Extension methods for converting typed routes to GoRouter routes.
///
/// Provides a fluent API for route configuration.
///
/// Example:
/// ```dart
/// final routes = [
///   AppRoutes.home.toGoRoute(
///     builder: (ctx, state, params) => const HomePage(),
///   ),
///   AppRoutes.user.toGoRoute(
///     builder: (ctx, state, params) => UserPage(id: params!.userId),
///     children: [
///       AppRoutes.userProfile.toGoRoute(
///         builder: (ctx, state, params) => UserProfilePage(),
///       ),
///     ],
///   ),
/// ];
/// ```
extension AppRouteExtension<T extends RouteParams> on AppRoute<T> {
  /// Creates a [GoRoute] from this typed route.
  ///
  /// [builder] receives the typed parameters extracted from the route state.
  /// [children] are nested routes that inherit this route's path.
  /// [redirect] provides route-specific redirect logic.
  GoRoute toGoRoute({
    required AppPageBuilder<T> builder,
    List<RouteBase> children = const [],
    String? Function(BuildContext, GoRouterState)? redirect,
  }) {
    return GoRoute(
      name: name,
      path: path,
      redirect: redirect,
      routes: children,
      builder: (context, state) {
        final params = extractParams(state.pathParameters);
        return builder(context, state, params);
      },
    );
  }

  /// Creates a [GoRoute] with a custom page transition.
  ///
  /// Use for routes that need specific transition animations.
  ///
  /// Example:
  /// ```dart
  /// AppRoutes.modal.toGoRoutePage(
  ///   pageBuilder: (ctx, state, params) => CustomTransitionPage(
  ///     child: ModalPage(),
  ///     transitionsBuilder: (ctx, animation, _, child) {
  ///       return SlideTransition(
  ///         position: Tween(begin: Offset(0, 1), end: Offset.zero)
  ///             .animate(animation),
  ///         child: child,
  ///       );
  ///     },
  ///   ),
  /// );
  /// ```
  GoRoute toGoRoutePage({
    required Page<dynamic> Function(BuildContext, GoRouterState, T?)
    pageBuilder,
    List<RouteBase> children = const [],
    String? Function(BuildContext, GoRouterState)? redirect,
  }) {
    return GoRoute(
      name: name,
      path: path,
      redirect: redirect,
      routes: children,
      pageBuilder: (context, state) {
        final params = extractParams(state.pathParameters);
        return pageBuilder(context, state, params);
      },
    );
  }
}

/// Helper function to build a list of GoRoutes from typed configurations.
///
/// Example:
/// ```dart
/// final routes = buildAppRoutes([
///   AppRouteConfig(
///     route: AppRoutes.home,
///     builder: (ctx, state, params) => const HomePage(),
///   ),
///   AppRouteConfig(
///     route: AppRoutes.dashboard,
///     builder: (ctx, state, params) => const DashboardPage(),
///   ),
/// ]);
/// ```
List<GoRoute> buildAppRoutes(List<AppRouteConfig> configs) {
  return configs.map((config) => config.toGoRoute()).toList();
}
