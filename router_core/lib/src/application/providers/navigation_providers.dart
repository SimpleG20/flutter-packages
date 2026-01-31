import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/interfaces/navigation_service.dart';

/// Provider for the [NavigationService].
///
/// Requires [routerProvider] (the GoRouter instance) to be available or injected.
/// Since GoRouter is typically provided by the app, we assume a provider named `routerProvider` exists
/// or the user overrides this.
///
/// However, to avoid assuming the name of the router provider, we define this as a
/// provider that MUST be overridden or we accept a GoRouter argument?
/// Better: Expect a [GoRouter] instance.
///
/// Example:
/// ```dart
/// final router = GoRouter(...);
/// final container = ProviderContainer(
///   overrides: [
///     navigationServiceProvider.overrideWithValue(NavigationServiceImpl(router)),
///   ],
/// );
/// ```
final navigationServiceProvider = Provider<NavigationService>((ref) {
  throw UnimplementedError(
    'Initialize navigationServiceProvider with a GoRouter instance',
  );
});
