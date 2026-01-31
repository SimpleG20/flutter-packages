import 'dart:async';
import 'guard_context.dart';
import 'guard_result.dart';

/// Abstract base class for route guards.
///
/// Guards are middlewares that verify whether a navigation action
/// should be allowed, blocked, or redirected.
abstract class RouteGuard {
  const RouteGuard();

  /// Unique name for debugging.
  String get name;

  /// Performs the check logic.
  ///
  /// Returns a [GuardResult] indicating the outcome.
  FutureOr<GuardResult> check(GuardContext context);

  /// Checks if this guard applies to the specific [location].
  ///
  /// Defaults to true (global guard). Override to restrict to specific paths.
  bool appliesTo(String location) => true;
}

/// Functional guard wrapper for simple checks.
class FunctionalGuard extends RouteGuard {
  @override
  final String name;
  final FutureOr<GuardResult> Function(GuardContext) onCheck;

  const FunctionalGuard(this.name, this.onCheck);

  @override
  FutureOr<GuardResult> check(GuardContext context) => onCheck(context);
}
