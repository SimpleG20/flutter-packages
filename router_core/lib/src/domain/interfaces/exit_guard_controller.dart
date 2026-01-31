import 'package:flutter/widgets.dart';

import '../entities/exit_guard_config.dart';

/// Interface for controlling exit guard registration and behavior.
///
/// Implementations handle the coordination between pages that want protection
/// and the navigation system that needs to intercept back navigation.
abstract interface class IExitGuardController {
  /// Registers a route for exit guard protection.
  ///
  /// Call this when a page that needs protection is mounted.
  /// [path] should match the route's path from GoRouter.
  /// [config] optionally overrides the default dialog configuration.
  void registerRoute(String path, {ExitGuardConfig? config});

  /// Unregisters a route from exit guard protection.
  ///
  /// Call this when a protected page is unmounted.
  void unregisterRoute(String path);

  /// Updates the dirty state for a registered route.
  ///
  /// [isDirty] should be true when there are unsaved changes.
  void setDirty(String path, bool isDirty);

  /// Determines whether the current pop action should be allowed.
  ///
  /// When the guard is active and dirty, this shows the confirmation dialog
  /// and returns true only if the user confirms they want to leave.
  /// Returns true immediately if no guard is active or not dirty.
  Future<bool> shouldAllowPop(BuildContext context);
}
