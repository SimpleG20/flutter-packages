import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/exit_guard_config.dart';
import '../../domain/entities/exit_guard_state.dart';

/// StateNotifier that manages exit guard state across the application.
///
/// Tracks which routes are guarded and their current dirty state.
/// Used by [ExitGuardShell] to determine if navigation should be blocked.
class ExitGuardNotifier extends StateNotifier<ExitGuardState> {
  ExitGuardNotifier() : super(const ExitGuardState());

  /// Registers a route for exit guard protection.
  ///
  /// Sets the guard as enabled and stores the route path.
  void registerRoute(String path, {ExitGuardConfig? config}) {
    state = state.copyWith(
      isEnabled: true,
      routePath: path,
      config: config,
      // Reset dirty state when registering new route
      isDirty: false,
    );
  }

  /// Unregisters a route from exit guard protection.
  ///
  /// Only unregisters if the path matches the currently registered route.
  void unregisterRoute(String path) {
    if (state.routePath == path) {
      state = const ExitGuardState();
    }
  }

  /// Updates the dirty state for the current route.
  ///
  /// [isDirty] should be true when there are unsaved changes.
  void setDirty(bool isDirty) {
    if (!state.isEnabled) return;
    state = state.copyWith(isDirty: isDirty);
  }

  /// Checks if a specific route is currently registered.
  bool isRouteRegistered(String path) => state.routePath == path;

  /// Clears the dirty state without unregistering.
  ///
  /// Useful when changes are saved and navigation should be allowed.
  void clearDirty() {
    state = state.copyWith(isDirty: false);
  }
}
