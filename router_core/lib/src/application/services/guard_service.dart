import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/guard_context.dart';
import '../../domain/entities/guard_result.dart';
import '../../domain/entities/route_guard.dart';

/// Service responsible for managing and evaluating route guards.
///
/// Guards are evaluated in registration order. The first guard to
/// block or redirect stops the chain.
class GuardService {
  final List<RouteGuard> _guards = [];

  GuardService([List<RouteGuard>? guards]) {
    if (guards != null) {
      _guards.addAll(guards);
    }
  }

  /// Registers a new guard.
  void register(RouteGuard guard) {
    if (!_guards.contains(guard)) {
      _guards.add(guard);
      debugPrint('[GuardService] Registered guard: ${guard.name}');
    }
  }

  /// Unregisters an existing guard.
  void unregister(RouteGuard guard) {
    _guards.remove(guard);
    debugPrint('[GuardService] Unregistered guard: ${guard.name}');
  }

  /// Returns a read-only list of active guards.
  List<RouteGuard> get guards => List.unmodifiable(_guards);

  /// Evaluates all applicable guards for the given context.
  ///
  /// Iterates through registered guards. The first guard to return
  /// a result other than [GuardResult.allowed] stops the chain.
  Future<GuardResult> evaluate(GuardContext context) async {
    for (final guard in _guards) {
      // Check if guard applies to this location
      // Note: This matches simple prefixes. For stricter matching,
      // guards should implement their own custom logic inside `check`.
      if (!guard.appliesTo(context.location)) continue;

      try {
        final result = await guard.check(context);

        // If not allowed (Blocked or Redirect), return immediately
        final isAllowed = result.maybeWhen(
          allowed: () => true,
          orElse: () => false,
        );

        if (!isAllowed) {
          debugPrint(
            '[GuardService] Navigation to ${context.location} INTERCEPTED '
            'by ${guard.name}: $result',
          );
          return result;
        }
      } catch (e, stack) {
        debugPrint(
          '[GuardService] Error executing guard ${guard.name}: $e\n$stack',
        );
        // Fail closed on error
        return const GuardResult.blocked(
          reason: 'Internal error executing guard',
        );
      }
    }

    return const GuardResult.allowed();
  }

  /// Redirect callback for GoRouter.
  ///
  /// Usage:
  /// ```dart
  /// GoRouter(
  ///   redirect: guardService.onRedirect,
  ///   ...
  /// )
  /// ```
  Future<String?> onRedirect(BuildContext context, GoRouterState state) async {
    final guardContext = GuardContext(
      location: state.uri.toString(),
      pathParameters: state.pathParameters,
      queryParameters: state.uri.queryParameters,
      extra: state.extra,
    );

    final result = await evaluate(guardContext);

    return result.maybeWhen(
      redirect: (location, extra) {
        if (extra != null) {
          debugPrint(
            '[GuardService] Warning: redirect extra data "$extra" '
            'is ignored because GoRouter redirect does not support it.',
          );
        }
        return location;
      },
      // For blocked, we return null so specific handling isn't enforced here.
      // Ideally, blocked guards should return a Redirect to an error page
      // or the previous page if they want to stop navigation in GoRouter.
      // Returning null in redirect() means "continue navigation".
      // TODO: Improve blocked handling if GoRouter adds support for cancelling.
      orElse: () => null,
    );
  }
}
