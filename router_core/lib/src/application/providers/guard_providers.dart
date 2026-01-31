import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../services/guard_service.dart';

/// Provider for the global [GuardService] instance.
///
/// Override this in the root [ProviderScope] to supply a custom
/// configured service or mock.
final guardServiceProvider = Provider<GuardService>((ref) {
  return GuardService();
});

/// Provider for the GoRouter redirect callback.
///
/// Connects the [GuardService] to GoRouter.
///
/// Usage:
/// ```dart
/// GoRouter(
///   redirect: ref.read(guardRedirectProvider),
///   // ...
/// );
/// ```
final guardRedirectProvider = Provider<GoRouterRedirect>((ref) {
  return ref.watch(guardServiceProvider).onRedirect;
});
