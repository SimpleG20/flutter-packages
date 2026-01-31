import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/providers/exit_guard_providers.dart';

// -----------------------------------------------------------------------------
// Safe Navigation Wrappers
// -----------------------------------------------------------------------------

/// Wrapper for context.go() that checks for exit confirmation using ExitGuard.
///
/// If the current route is "dirty" (has unsaved changes), this will show
/// the confirmation dialog managed by [ExitGuardController].
Future<bool> safeGo({
  required BuildContext context,
  required String location,
  Object? extra,
}) async {
  if (!context.mounted) return false;

  final container = ProviderScope.containerOf(context, listen: false);
  final controller = container.read(exitGuardControllerProvider);

  // Check if we can pop/navigate away
  final allowed = await controller.shouldAllowPop(context);
  if (!allowed) return false;

  if (context.mounted) {
    context.go(location, extra: extra);
    return true;
  }
  return false;
}

/// Wrapper for context.goNamed() that checks for exit confirmation.
Future<bool> safeGoNamed({
  required BuildContext context,
  required String name,
  Map<String, String> pathParameters = const <String, String>{},
  Map<String, dynamic> queryParameters = const <String, dynamic>{},
  Object? extra,
}) async {
  if (!context.mounted) return false;

  final container = ProviderScope.containerOf(context, listen: false);
  final controller = container.read(exitGuardControllerProvider);

  final allowed = await controller.shouldAllowPop(context);
  if (!allowed) return false;

  if (context.mounted) {
    context.goNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
    return true;
  }
  return false;
}

/// Wrapper for context.push() that checks for exit confirmation.
Future<bool> safePush({
  required BuildContext context,
  required String location,
  Object? extra,
}) async {
  if (!context.mounted) return false;

  final container = ProviderScope.containerOf(context, listen: false);
  final controller = container.read(exitGuardControllerProvider);

  final allowed = await controller.shouldAllowPop(context);
  if (!allowed) return false;

  if (context.mounted) {
    await context.push(location, extra: extra);
    return true;
  }
  return false;
}

/// Wrapper for context.pushNamed() that checks for exit confirmation.
Future<bool> safePushNamed({
  required BuildContext context,
  required String name,
  Map<String, String> pathParameters = const <String, String>{},
  Map<String, dynamic> queryParameters = const <String, dynamic>{},
  Object? extra,
}) async {
  if (!context.mounted) return false;

  final container = ProviderScope.containerOf(context, listen: false);
  final controller = container.read(exitGuardControllerProvider);

  final allowed = await controller.shouldAllowPop(context);
  if (!allowed) return false;

  if (context.mounted) {
    await context.pushNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
    return true;
  }
  return false;
}

/// Wrapper for context.pop() that respects exit confirmation.
///
/// This is semantically equivalent to calling `context.pop()`, as the
/// underlying [PopScope] will automatically intercept the pop if the guard
/// is active. Provided for API symmetry.
void safePop(BuildContext context, [dynamic result]) {
  if (context.mounted) {
    context.pop(result);
  }
}

// -----------------------------------------------------------------------------
// Unsafe Navigation Wrappers (Direct Pass-through)
// -----------------------------------------------------------------------------

/// Wrapper for context.go() that explicitly IGNORES exit confirmation.
bool unsafeGo({
  required BuildContext context,
  required String location,
  Object? extra,
}) {
  if (!context.mounted) return false;
  context.go(location, extra: extra);
  return true;
}

/// Wrapper for context.goNamed() that explicitly IGNORES exit confirmation.
bool unsafeGoNamed({
  required BuildContext context,
  required String name,
  Map<String, String> pathParameters = const <String, String>{},
  Map<String, dynamic> queryParameters = const <String, dynamic>{},
  Object? extra,
}) {
  if (!context.mounted) return false;
  context.goNamed(
    name,
    pathParameters: pathParameters,
    queryParameters: queryParameters,
    extra: extra,
  );
  return true;
}

/// Wrapper for context.push() that explicitly IGNORES exit confirmation.
Future<bool> unsafePush({
  required BuildContext context,
  required String location,
  Object? extra,
}) async {
  if (!context.mounted) return false;
  await context.push(location, extra: extra);
  return true;
}

/// Wrapper for context.pushNamed() that explicitly IGNORES exit confirmation.
Future<bool> unsafePushNamed({
  required BuildContext context,
  required String name,
  Map<String, String> pathParameters = const <String, String>{},
  Map<String, dynamic> queryParameters = const <String, dynamic>{},
  Object? extra,
}) async {
  if (!context.mounted) return false;
  await context.pushNamed(
    name,
    pathParameters: pathParameters,
    queryParameters: queryParameters,
    extra: extra,
  );
  return true;
}

/// Wrapper for context.pop() that FORCEFULLY ignores exit confirmation.
///
/// Use this for "Cancel" buttons where you want to discard changes and leave
/// immediately without annoying the user with a dialog.
void unsafePop(BuildContext context, [dynamic result]) {
  if (!context.mounted) return;

  // 1. Force clear dirty state for current route
  try {
    final path = GoRouterState.of(context).uri.path;
    final container = ProviderScope.containerOf(context, listen: false);
    container.read(exitGuardControllerProvider).setDirty(path, false);
  } catch (e) {
    // If we can't find provider or path, just proceed to pop
    // (likely not in a guarded context anyway)
  }

  // 2. Pop
  if (context.mounted) {
    context.pop(result);
  }
}
