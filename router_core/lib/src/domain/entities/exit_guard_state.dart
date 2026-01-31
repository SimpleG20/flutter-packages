import 'package:freezed_annotation/freezed_annotation.dart';

import 'exit_guard_config.dart';

part 'exit_guard_state.freezed.dart';

/// Represents the current state of exit guard protection for a route.
///
/// This state is managed by [ExitGuardNotifier] and consumed by [ExitGuardShell]
/// to determine whether navigation should be blocked.
@freezed
abstract class ExitGuardState with _$ExitGuardState {
  const factory ExitGuardState({
    /// Whether the exit guard is currently active for any route.
    @Default(false) bool isEnabled,

    /// Whether the current route has unsaved changes.
    /// When true, navigation will trigger the confirmation dialog.
    @Default(false) bool isDirty,

    /// The route path currently being guarded.
    /// Null when no route is registered.
    String? routePath,

    /// Custom configuration for the exit dialog.
    /// Falls back to [ExitGuardConfig.defaultConfig] when null.
    ExitGuardConfig? config,
  }) = _ExitGuardState;

  const ExitGuardState._();

  /// Whether navigation should be blocked (guard is enabled AND has unsaved changes).
  bool get shouldBlock => isEnabled && isDirty;

  /// Returns the effective config, falling back to defaults.
  ExitGuardConfig get effectiveConfig =>
      config ?? ExitGuardConfig.defaultConfig;
}
